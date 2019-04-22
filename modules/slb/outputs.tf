output "vswitch_id" {
  description = "The ID of the SLB Vswitch"
  value       = "${alicloud_vswitch.vswitch-slb.id}"
}

output "slb_id" {
  description = "The ID of the SLB"
  value       = "${alicloud_slb.slb.id}"
}

output "slb_name" {
  description = "The name of the SLB"
  value       = "${alicloud_slb.slb.name}"
}

output "slb_address" {
  description = "The IP address of the ELB"
  value       = "${alicloud_slb.slb.address}"
}
