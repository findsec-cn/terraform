locals {
  this_nat_gateway_id    = "${alicloud_nat_gateway.this_nat_gateway.id}"
  this_forward_table_ids = "${alicloud_nat_gateway.this_nat_gateway.forward_table_ids}"
  this_snat_table_ids    = "${alicloud_nat_gateway.this_nat_gateway.snat_table_ids}"
}

output "this_nat_gateway_id" {
  value = "${local.this_nat_gateway_id}"
}

output "this_forward_table_ids" {
  value = "${local.this_forward_table_ids}"
}

output "this_snat_table_ids" {
  value = "${local.this_snat_table_ids}"
}
