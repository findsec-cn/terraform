resource "alicloud_nat_gateway" "this_nat_gateway" {
  count         = "${var.nat_gateway_id == "" ? 1 : 0}"
  vpc_id        = "${var.vpc_id}"
  name          = "${var.name}"
  specification = "${var.specification}"
  description   = "${var.description}"
}
