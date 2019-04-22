terraform {
  required_version = ">= 0.11.0"
}

provider "alicloud" {
  region = "${var.ALICLOUD_REGION}"
}

module "vpc" {
  source = "modules/vpc"

  vpc_name = "vpc-${var.cluster_name}"
  vpc_cidr = "${var.vpc_cidr}"

  vswitch_cidrs = "${var.vswitch_cidrs}"
  vswitch_name = "vsw-${var.cluster_name}"
  availability_zones = "${var.availability_zones}"
}

resource "alicloud_eip" "eip" {
  bandwidth = 1
}

module "nat_gateway" {
  source = "modules/nat_gateway"

  vpc_id = "${module.vpc.vpc_id}"
  name   = "gw"
}

resource "alicloud_eip_association" "nat-gateway" {
  allocation_id = "${alicloud_eip.eip.id}"
  instance_id   = "${module.nat_gateway.this_nat_gateway_id}"
}

module "snat_entry" {
  source = "modules/snat_entry"

  snat_count         = 1
  snat_table_id      = "${element(split(",", module.nat_gateway.this_snat_table_ids), 1)}"
  source_vswitch_ids = "${split(",", module.vpc.vswitch_ids)}"
  snat_ips           = ["${alicloud_eip.eip.ip_address}"]
}

module "sg" {
  source = "modules/security-group"

  group_name = "sg-${var.cluster_name}"
  vpc_id = "${module.vpc.vpc_id}"

  rule_directions = ["ingress"]
  ip_protocols = ["tcp", "tcp", "tcp", "tcp"]
  policies = ["accept", "accept", "accept", "accept"]
  port_ranges = ["80/80", "443/443","6443/6443", "22/22"]
  priorities = [1, 2, 3, 4]
  cidr_ips = ["0.0.0.0/0"]
}

/*
* Create K8s Master and worker nodes instances
*
*/

resource "alicloud_instance" "bastion-server" {

  image_id = "${data.alicloud_images.ecs_image.images.0.id}"
  instance_type = "${var.bastion_size}"
  internet_max_bandwidth_out = "${var.bastion_internet_max_bandwidth_out}"

  availability_zone = "${element(var.availability_zones,count.index)}"
  security_groups = ["${module.sg.security_group_id}"]

  vswitch_id = "${element(split(",", module.vpc.vswitch_ids),count.index)}"

  instance_name = "${var.cluster_name}-bastion-${count.index}"
  host_name     = "${var.cluster_name}-bastion-${count.index}"

  key_name      = "${var.SSH_KEY_NAME}"

  tags = "${merge(var.default_tags, map(
    "Name", "${var.cluster_name}-bastion-${count.index}",
    "Role", "bastion-server"
  ))}"
}

resource "alicloud_instance" "k8s-master" {

  count = "${var.k8s_master_num}"

  image_id = "${data.alicloud_images.ecs_image.images.0.id}"
  instance_type = "${var.k8s_master_size}"

  availability_zone = "${element(var.availability_zones,count.index)}"
  security_groups = ["${module.sg.security_group_id}"]

  vswitch_id = "${element(split(",", module.vpc.vswitch_ids),count.index)}"

  instance_name = "${var.cluster_name}-master-${count.index}"
  host_name     = "${var.cluster_name}-master-${count.index}"

  key_name      = "${var.SSH_KEY_NAME}"

  tags = "${merge(var.default_tags, map(
    "Name", "${var.cluster_name}-master-${count.index}",
    "Role", "k8s-master"
  ))}"
}

resource "alicloud_instance" "k8s-worker" {

  count = "${var.k8s_worker_num}"

  image_id = "${data.alicloud_images.ecs_image.images.0.id}"
  instance_type = "${var.k8s_worker_size}"

  availability_zone = "${element(var.availability_zones,count.index)}"
  security_groups = ["${module.sg.security_group_id}"]

  vswitch_id = "${element(split(",", module.vpc.vswitch_ids),count.index)}"

  instance_name = "${var.cluster_name}-worker-${count.index}"
  host_name     = "${var.cluster_name}-worker-${count.index}"

  key_name      = "${var.SSH_KEY_NAME}"

  tags = "${merge(var.default_tags, map(
    "Name", "${var.cluster_name}-worker-${count.index}",
    "Role", "k8s-worker"
  ))}"
}

# Create a new SLB for K8S
module "slb" {
  source = "modules/slb"

  vpc_id = "${module.vpc.vpc_id}"
  vswitch_name = "${var.slb_vswitch_name}"
  vswitch_cidr = "${var.slb_vswitch_cidr}"
  availability_zone = "${var.slb_availability_zone}"

  name = "${var.cluster_name}-slb"
  internet = "${var.slb_internet}"
  
  instances = ["${alicloud_instance.k8s-master.*.id}"]
}

resource "alicloud_eip" "eip-slb" {
  bandwidth = 1
}

resource "alicloud_eip_association" "slb" {
  allocation_id = "${alicloud_eip.eip-slb.id}"
  instance_id   = "${module.slb.slb_id}"
}

module "slb-listener" {
  source = "modules/slb-listener"

  slb = "${module.slb.slb_id}"
  backend_port = "${var.k8s_apiserver_port}"
  frontend_port = "${var.k8s_apiserver_port}"
  protocol = "tcp"
  bandwidth = "1000"
  health_check_type = "tcp"
}

/*
* Create Kubespray Inventory File
*
*/
data "template_file" "inventory" {
  template = "${file("${path.module}/templates/inventory.tpl")}"

  vars {
    public_ip_address_bastion = "${join("\n",formatlist("bastion ansible_host=%s" , alicloud_instance.bastion-server.*.public_ip))}"
    connection_strings_master = "${join("\n",formatlist("%s ansible_host=%s",alicloud_instance.k8s-master.*.tags.Name, alicloud_instance.k8s-master.*.private_ip))}"
    connection_strings_node = "${join("\n", formatlist("%s ansible_host=%s", alicloud_instance.k8s-worker.*.tags.Name, alicloud_instance.k8s-worker.*.private_ip))}"
    list_master = "${join("\n",alicloud_instance.k8s-master.*.tags.Name)}"
    list_node = "${join("\n",alicloud_instance.k8s-worker.*.tags.Name)}"
    slb_api_fqdn = "apiserver_loadbalancer_domain_name=\"${module.slb.slb_address}\""
  }

}

resource "null_resource" "inventories" {
  provisioner "local-exec" {
    command = "echo '${data.template_file.inventory.rendered}' > ${var.inventory_file}"
  }

  triggers {
    template = "${data.template_file.inventory.rendered}"
  }

}

