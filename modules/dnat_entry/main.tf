resource "alicloud_forward_entry" "this_forward_entry" {
  count            = "${var.dnat_count ? var.dnat_count : 0}"
  forward_table_id = "${var.forward_table_id}"
  external_ip      = "${element(var.external_ips, count.index)}"
  external_port    = "${element(var.external_ports, count.index)}"
  ip_protocol      = "${element(var.ip_protocols, count.index)}"
  internal_ip      = "${element(var.internal_ips, count.index)}"
  internal_port    = "${element(var.internal_ports, count.index)}"
}
