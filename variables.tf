# 通用集群变量
variable "SSH_KEY_NAME" {
  description = "Name of the SSH keypair to use in ECS."
}

variable "ALICLOUD_REGION" {
  description = "ALICLOUD Region"
}

variable "cluster_name" {
  description = "Name of AliCloud Cluster"
}

variable "default_tags" {
  description = "Default tags for all resources"
  type = "map"
}

data "alicloud_images" "ecs_image" {
  most_recent = true
  name_regex  = "^centos_7\\w{1,5}[64].*"
}

# 安全组变量
variable "vpc_cidr" {
  description = "VPC 网段及掩码"
}

variable "vswitch_cidrs" {
  description = "Vswitch 网段及掩码"
  type        = "list"
}

variable "availability_zones" {
  description = "可用区"
  type        = "list"
}

# 安全组变量
variable "group_description" {
  description = "安全组描述"
  default     = "Kubernetes Security Group"
}

# ECS变量
variable "bastion_size" {
    description = "ECS Instance Size of Bastion Host"
}

variable "bastion_internet_max_bandwidth_out" {
    description = "The maximum internet out bandwidth of instance Bastion Host"
}

variable "k8s_master_num" {
  description = "Number of Kubernetes Master Nodes"
}

variable "k8s_master_size" {
  description = "Instance size of Kubernetes Master Nodes"
}

variable "k8s_worker_num" {
  description = "Number of Kubernetes Worker Nodes"
}

variable "k8s_worker_size" {
  description = "Instance size of Kubernetes Worker Nodes"
}

# SLB变量
variable "slb_vswitch_name" {
  description = "SLB Vswitch name"
  default     = "vsw-slb"
}

variable "slb_vswitch_cidr" {
  description = "SLB Vswitch CIDR block"
}

variable "slb_availability_zone" {
  description = "SLB Availability Zone"
}

variable "slb_internet" {
  description = "If false, SLB instance will be an internal SLB"
}

variable "k8s_apiserver_port" {
  description = "Secure Port of K8S API Server"
}

variable "inventory_file" {
  description = "Where to store the generated inventory file"
}

