module "module_vpc" {
  source = "alibaba/vpc/alicloud"

  vpc_name = "my_module_vpc"

  vswitch_name = "my_module_vswitch"

  vswitch_cidrs = [
    "172.16.1.0/24",
  ]
}

resource "alicloud_eip" "default" {
  bandwidth = 5
}

resource "alicloud_eip" "default2" {
  bandwidth = 5
}

resource "alicloud_eip_association" "default" {
  allocation_id = "${element(alicloud_eip.default.*.id, count.index)}"
  instance_id   = "${module.nat_gateway.this_nat_gateway_id}"
}

resource "alicloud_eip_association" "default2" {
  allocation_id = "${element(alicloud_eip.default2.*.id, count.index)}"
  instance_id   = "${module.nat_gateway.this_nat_gateway_id}"
}

module "nat_gateway" {
  source = "../modules/nat_gateway"

  ###############################################################
  #variables for nat gateway
  ##############################################################
  vpc_id = "${module.module_vpc.vpc_id}"
}

module "dnat_entry" {
  source = "../modules/dnat_entry"

  ###############################################################
  #variables for dnat entry
  ##############################################################
  dnat_count = 1

  forward_table_id = "${element(split(",", module.nat_gateway.this_forward_table_ids), 1)}"
  external_ips     = "${split(",", alicloud_eip.default.0.ip_address)}"
  external_ports   = ["80"]
  ip_protocols     = ["tcp"]
  internal_ips     = ["172.16.1.0"]
  internal_ports   = ["8080"]
}

module "snat_entry" {
  source = "../modules/snat_entry"

  ###############################################################
  #variables for db snat entry
  ##############################################################
  snat_count = 1

  snat_table_id      = "${element(split(",", module.nat_gateway.this_snat_table_ids), 1)}"
  source_vswitch_ids = "${split(",", module.module_vpc.vswitch_ids)}"
  snat_ips           = "${split(",",alicloud_eip.default2.0.ip_address)}"
}
