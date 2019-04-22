output "this_nat_gateway_id" {
  value = "${module.nat_gateway.this_nat_gateway_id}"
}

output "this_forward_table_ids" {
  value = "${module.nat_gateway.this_forward_table_ids}"
}

output "this_snat_table_ids" {
  value = "${module.nat_gateway.this_snat_table_ids}"
}

output "vpc_id" {
  value = "${module.module_vpc.vpc_id}"
}

output "vswitch_ids" {
  value = "${module.module_vpc.vswitch_ids}"
}
