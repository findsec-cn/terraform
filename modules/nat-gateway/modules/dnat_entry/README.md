# alicloud_dnat_entry

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
|dnat_count               | Number of dnat entry.    |  int     |     no      | yes | 
|forward_table_id               | The forward table id of dnat entry.    |  string     |     no      | yes |  
|external_ips       | The external ip id of dnat entry. The length should be equal to dnat_count.  |   list  |    no    |    yes       | 
|internal_ips       | The internal ip of dnat entry. The length should be equal to dnat_count.  |   list  |    no    |    yes       |
|external_ports       | The external port of dnat entry. The length should be equal to dnat_count.  |   list  |    no    |    yes       |
|internal_ports       | The internal port of dnat entry. The length should be equal to dnat_count.  |   list  |    no    |    yes       |
|ip_protocols       | The ip protocols of dnat entry. The length should be equal to dnat_count.  |   list  |    no    |    yes       |

