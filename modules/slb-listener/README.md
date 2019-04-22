Alicloud Load Balancer (SLB) Listener Terraform Module
======================================================

Terraform module which creates SLB HTTP, HTTPS, TCP or UDP Listener resources on Alibaba Cloud.

These types of resources are supported:

* [SLB Listener](https://www.terraform.io/docs/providers/alicloud/r/slb_listener.html)

Usage
-----
You can use this in your terraform template with the following steps.

1. Adding a module resource to your template, e.g. main.tf


         module "tf-slb" {
            source = "terraform-alicloud-modules/slb-listener/alicloud"

            slb = "lb-f893h8c4c"

            protocol = "http"
            backend_port = 8080
            frontend_port = 80

            enable_health_check = true
            health_check_connect_port = 80
            health_check_uri = "www.alibabacloud.com"

         }

2. Setting values for the following variables through environment variables:

    - ALICLOUD_ACCESS_KEY
    - ALICLOUD_SECRET_KEY


Authors
-------
Created and maintained by He Guimin(@xiaozhu36 heguimin36@163.com)

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)
