# VSwitch variables
variable "vpc_id" {
  description = "The vpc id used to launch load balancer."
  default     = ""
}

variable "vswitch_name" {
  description = "The vswitch name used to launch load balancer."
  default     = "vsw-slb"
}

variable "vswitch_cidr" {
  description = "The vswitch cidr block used to launch load balancer."
  default     = "172.22.1.0/24"
}

variable "availability_zone" {
  description = "The availability zone used to launch load balancer."
  default     = "cn-beijing-e"
}

# Load Balancer Instance variables
variable "name" {
  description = "The name of a new load balancer."
  default     = "slb"
}

variable "internet" {
  description = "If false, SLB instance will be an internal SLB."
  default     = false
}

variable "internet_charge_type" {
  description = "The charge type of load balancer instance internet network."
  default     = "PayByTraffic"
}

variable "bandwidth" {
  description = "The load balancer instance bandwidth."
  default     = 100
}

variable "spec" {
  description = "The specification of the SLB instance."
  default     = ""
}

variable "instances" {
  description = "List of instances ID to place in the SLB pool"
  type        = "list"
}
