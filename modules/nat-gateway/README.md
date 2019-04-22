Alicloud Nat Gateway Terraform Module   
terraform-alicloud-nat-gateway
---

This Terraform module will first creates a nat gateway, then create forward entry and snat entry this instance.

NAT Gateway is an enterprise-class public network gateway, providing proxy services (SNAT and DNAT), up to 10 Gbps forwarding capacity, and cross-zone disaster recovery. NAT Gateway helps you establish an Internet gateway for a VPC by configuring SNAT and DNAT entries, allowing more flexible use of network resources.

Supports source network address translation (SNAT). VPC-connected ECS instances can use the same EIP to access the Internet.

Supports destination network address translation (SNAT). VPC-connected ECS instances can use the same EIP to deliver services to the Internet.

These types of resources are supported:

* [Alicloud_nat_gateway](https://www.terraform.io/docs/providers/alicloud/r/nat_gateway.html)
* [Alicloud_forward_entry](https://www.terraform.io/docs/providers/alicloud/r/forward.html)
* [Alicloud_snat_entry](https://www.terraform.io/docs/providers/alicloud/r/snat.html)

This module will use [Alicloud VPC](https://registry.terraform.io/modules/alibaba/vpc) to create a new VPC and several VSwitches when `vpc_id` is not set.

----------------------

Usage
-----
You can use this in your terraform template with the following steps.

1. Adding a module resource to your template, e.g. main.tf
    
```hcl
module "nat-gateway" {
  source = "terraform-alicloud-modules/nat-gateway/alicloud"

  #variables for nat gateway
  
  vpc_id = "vpc-abc123456"
  name = "module_nat_gateway"

  #variables for dnat entry
  
  dnat_count       = 1
  forward_table_id = "${element(split(",", module.nat_gateway.this_forward_table_ids), 1)}"
  external_ips      = ["39.96.18.46"]
  external_ports    = ["80"]
  ip_protocols      = ["tcp"]
  internal_ips      = ["172.16.1.0"]
  internal_ports    = ["8080"]

  #variables for snat entry

  snat_count        = 1
  snat_table_id     = "${element(split(",", module.nat_gateway.this_snat_table_ids), 1)}"
  source_vswitch_ids = ["vsw-abc123456"]
  snat_ips           = ["39.96.27.241"]

}
```

2. Setting `access_key` and `secret_key` values through environment variables:

    - ALICLOUD_ACCESS_KEY
    - ALICLOUD_SECRET_KEY
    - ALICLOUD_REGION


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
|name               | The name of nat gateway    |  string     |     terraform-alicloud-nat-gateway      | no |  
|vpc_id       | An existing vpc id used to create a new nat gateway.   |   string  |    no    |    yes       |
|nat_gateway_id       | The id of an existing nat gateway.   |   string  |    ""    |    no       |  
|specification       | The specification of nat gateway.   |   string  |    Small    |    no       | 
|description       | The description of nat gateway.   |   string  |    terraform-alicloud-nat-gateway    |    no       | 
|dnat_count               | Number of dnat entry.    |  int     |     no      | yes | 
|forward_table_id               | The forward table id of dnat entry.    |  string     |     no      | yes |  
|external_ips       | The external ip id of dnat entry. The length should be equal to dnat_count.  |   list  |    no    |    yes       | 
|internal_ips       | The internal ip of dnat entry. The length should be equal to dnat_count.  |   list  |    no    |    yes       |
|external_ports       | The external port of dnat entry. The length should be equal to dnat_count.  |   list  |    no    |    yes       |
|internal_ports       | The internal port of dnat entry. The length should be equal to dnat_count.  |   list  |    no    |    yes       |
|ip_protocols       | The ip protocols of dnat entry. The length should be equal to dnat_count.  |   list  |    no    |    yes       |
|snat_count               | Number of snat entry.    |  int     |     no      | yes |
|snat_table_id               | The snat table id of nat gateway.    |  string     |     no      | yes |  
|source_vswitch_ids       | The vswitch ids. The length should be equal to snat_count.  |   list  |    no    |    yes       | 
|snat_ips       | The snat ips of the nat gateway. The length should be equal to snat_count.  |   list  |    no    |    yes       |

## Outputs

| Name | Description |
|------|-------------|
| this_nat_gateway_id     |        nat gateway id created     |
| this_forward_table_ids     |    forword entry id created         |
| this_snat_table_ids     |   snat entry id created          |
| vpc_id     |    vpc id created         |
| vswitch_ids     |   vswitch_ids created          |


Authors
---------
Created and maintained by Ce Jin(@dianmuali, jince567@163.com)

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)
