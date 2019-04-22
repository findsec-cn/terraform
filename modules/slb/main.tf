# Create a new AliCloud SLB
resource "alicloud_vswitch" "vswitch-slb" {
  name              = "${var.vswitch_name}"
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${var.vswitch_cidr}"
  availability_zone = "${var.availability_zone}"
}

resource "alicloud_slb" "slb" {
  name                 = "${var.name}"
  internet_charge_type = "${var.internet_charge_type}"
  internet             = "${var.internet}"
  vswitch_id           = "${alicloud_vswitch.vswitch-slb.id}"
  specification        = "${var.spec}"
  bandwidth            = "${var.bandwidth}"
}

resource "alicloud_slb_attachment" "slb-attach" {
  load_balancer_id = "${alicloud_slb.slb.id}"
  instance_ids     = ["${var.instances}"]
}

