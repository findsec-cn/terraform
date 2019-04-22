# alicloud_nat_gateway

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
|name               | The name of nat gateway    |  string     |     terraform-alicloud-nat-gateway      | no |  
|vpc_id       | An existing vpc id used to create a new nat gateway.   |   string  |    no    |    yes       |
|nat_gateway_id       | The id of an existing nat gateway.   |   string  |    ""    |    no       |  
|specification       | The specification of nat gateway.   |   string  |    Small    |    no       | 
|description       | The description of nat gateway.   |   string  |    terraform-alicloud-nat-gateway    |    no       | 
