resource "alicloud_slb_listener" "this" {
  load_balancer_id = "${var.slb}"
  backend_port     = "${var.backend_port}"
  frontend_port    = "${var.frontend_port}"
  protocol         = "${var.protocol}"
  bandwidth        = "${var.bandwidth}"
  scheduler        = "${var.scheduler}"
  server_group_id  = "${var.server_group_id}"

  // Health Check
  healthy_threshold     = "${var.healthy_threshold}"
  unhealthy_threshold   = "${var.unhealthy_threshold}"
  health_check_timeout  = "${var.health_check_timeout}"
  health_check_interval = "${var.health_check_interval}"

  // HTTP and HTTPS
  sticky_session      = "${var.enable_sticky_session ? "on" : "off"}"
  sticky_session_type = "${var.sticky_session_type}"
  cookie              = "${var.cookie}"
  cookie_timeout      = "${var.cookie_timeout}"
  health_check        = "${var.enable_health_check ? "on" : "off"}"
  gzip                = "${var.enable_gzip}"

  x_forwarded_for = [{
    retrive_slb_ip    = "${var.retrive_slb_ip}"
    retrive_slb_id    = "${var.retrive_slb_id}"
    retrive_slb_proto = "${var.retrive_slb_proto}"
  }]

  // TCP, HTTP and HTTPS
  health_check_connect_port = "${var.health_check_connect_port  == "" ? var.backend_port : var.health_check_connect_port}"
  health_check_domain       = "${var.health_check_domain}"
  health_check_uri          = "${var.health_check_uri}"
  health_check_http_code    = "${var.health_check_http_code}"

  // TCP
  health_check_type = "${var.health_check_type}"

  // TCP and UDP
  persistence_timeout = "${var.persistence_timeout}"
}
