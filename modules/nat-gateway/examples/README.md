# Complete nat gateway example

Configuration in this directory creates nat gateway, snat entry and dnat entry.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Outputs

| Name | Description |
|------|-------------|
| this_nat_gateway_id     |        nat gateway id created     |
| this_forward_table_ids     |    forword entry id created         |
| this_snat_table_ids     |   snat entry id created          |
| vpc_id     |    vpc id created         |
| vswitch_ids     |   vswitch_ids created          |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->