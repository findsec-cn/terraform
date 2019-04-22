output "bastion_ip" {
    value = "${join("\n", alicloud_instance.k8s-master.*.public_ip)}"
}

output "masters" {
  value = "${join("\n", alicloud_instance.k8s-master.*.private_ip)}"
}

output "workers" {
  value = "${join("\n", alicloud_instance.k8s-worker.*.private_ip)}"
}

output "slb_api_fqdn" {
  value = "${module.slb.slb_address}:${var.k8s_apiserver_port}"
}

output "inventory" {
  value = "${data.template_file.inventory.rendered}"
}

output "default_tags" {
  value = "${var.default_tags}"
}

