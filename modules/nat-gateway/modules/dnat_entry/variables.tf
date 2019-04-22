variable "dnat_count" {
  description = "Number of dnat entry."
}

variable "forward_table_id" {
  description = "The forward table id of dnat entry."
}

variable "external_ips" {
  type        = "list"
  description = "The external ip id of dnat entry. The length should be equal to dnat_count."
}

variable "internal_ips" {
  type        = "list"
  description = "The internal ip of dnat entry. The length should be equal to dnat_count."
}

variable "external_ports" {
  type        = "list"
  description = "The external port of dnat entry. The length should be equal to dnat_count."
}

variable "internal_ports" {
  type        = "list"
  description = "The internal port of dnat entry. The length should be equal to dnat_count."
}

variable "ip_protocols" {
  type        = "list"
  description = "The ip protocols of dnat entry. The length should be equal to dnat_count."
}
