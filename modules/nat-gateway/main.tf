module "module_vpc" {
  source = "alibaba/vpc/alicloud"

  vpc_id   = "${var.vpc_id}"
  vpc_name = "${var.name}"

  vswitch_name  = "${var.name}"
  vswitch_cidrs = "${var.vswitch_cidrs}"
}

module "nat_gateway" {
  source = "./modules/nat_gateway"

  ###############################################################
  #variables for nat gateway
  ##############################################################
  vpc_id = "${module.module_vpc.vpc_id}"

  name          = "${var.name}"
  specification = "${var.specification}"
  description   = "${var.description}"
}

module "dnat_entry" {
  source = "./modules/dnat_entry"

  ###############################################################
  #variables for dnat entry
  ##############################################################
  dnat_count = "${var.dnat_count}"

  forward_table_id = "${var.forward_table_id}"
  external_ips     = "${var.external_ips}"
  external_ports   = "${var.external_ports}"
  ip_protocols     = "${var.ip_protocols}"
  internal_ips     = "${var.internal_ips}"
  internal_ports   = "${var.internal_ports}"
}

module "snat_entry" {
  source = "./modules/snat_entry"

  ###############################################################
  #variables for db snat entry
  ##############################################################
  snat_count = "${var.snat_count}"

  snat_table_id      = "${var.snat_table_id}"
  source_vswitch_ids = "${split(",", module.module_vpc.vswitch_ids)}"
  snat_ips           = "${var.snat_ips}"
}
