[all]
${connection_strings_master}
${connection_strings_node}
${public_ip_address_bastion}


[bastion]
${public_ip_address_bastion}


[kube-master]
${list_master}


[kube-node]
${list_node}


[k8s-cluster:children]
kube-node
kube-master


[k8s-cluster:vars]
${slb_api_fqdn}
