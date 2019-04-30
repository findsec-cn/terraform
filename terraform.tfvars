#Global Vars
ALICLOUD_REGION = "cn-beijing"
SSH_KEY_NAME = "sshkey"
cluster_name = "k8s"

#VPC Vars
vpc_cidr = "172.16.0.0/16"
vswitch_cidrs = ["172.16.10.0/24"]
availability_zones = ["cn-beijing-f"]

#Bastion Host
bastion_size = "ecs.t5-lc2m1.nano"
bastion_internet_max_bandwidth_out = "1"
bastion_private_ip = "172.16.10.100"

#Kubernetes Cluster
k8s_master_num = 3
k8s_master_size = "ecs.c5.large"
k8s_master_private_ips = ["172.16.10.10", "172.16.10.11", "172.16.10.12"]

k8s_worker_num = 3
k8s_worker_size = "ecs.c5.large"
k8s_worker_private_ips = ["172.16.10.20", "172.16.10.21", "172.16.10.22"]

#Settings SLB
slb_vswitch_cidr = "172.16.1.0/24"
slb_availability_zone = "cn-beijing-f"
slb_internet = false
k8s_apiserver_port = 6443

default_tags = {
  Env = "prod"
  Product = "kubernetes"
}

inventory_file = "./inventory/hosts.ini"

