# alicloud_snat_entry

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
|snat_count               | Number of snat entry.    |  int     |     no      | yes |
|snat_table_id               | The snat table id of nat gateway.    |  string     |     no      | yes |  
|source_vswitch_ids       | The vswitch ids. The length should be equal to snat_count.  |   list  |    no    |    yes       | 
|snat_ips       | The snat ips of the nat gateway. The length should be equal to snat_count.  |   list  |    no    |    yes       |


       |