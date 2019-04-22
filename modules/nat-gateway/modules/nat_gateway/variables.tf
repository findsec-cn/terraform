variable "name" {
  default = "terraform-alicloud-nat-gateway"
}

variable "vpc_id" {
  description = "An existing vpc id used to create a new nat gateway."
}

variable "nat_gateway_id" {
  description = "The id of an existing nat gateway."
  default     = ""
}

variable "specification" {
  description = "The specification of nat gateway."
  default     = "Small"
}

variable "description" {
  description = "The description of nat gateway."
  default     = "terraform-alicloud-nat-gateway"
}
