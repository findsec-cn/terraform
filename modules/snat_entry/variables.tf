variable "snat_count" {
  description = "Number of snat entry."
}

variable "snat_table_id" {
  description = "The snat table id of nat gateway."
}

variable "source_vswitch_ids" {
  type        = "list"
  description = "The vswitch ids. The length should be equal to snat_count."
}

variable "snat_ips" {
  type        = "list"
  description = "The snat ips of the nat gateway. The length should be equal to snat_count."
}
