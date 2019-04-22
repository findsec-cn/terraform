# Load Balancer Instance variables
variable "slb" {
  description = "The load balancer ID used to add a new listener."
}

# Listener common variables
variable "protocol" {
  description = "The protocol to listen on."
}

variable "backend_port" {
  description = "Port used by the Server Load Balancer instance backend."
}

variable "frontend_port" {
  description = "Port used by the Server Load Balancer instance frontend."
}

variable "bandwidth" {
  description = "Bandwidth peak of Listener. Valid in -1/1-1000Mbps and -1 means there is no limit when SLB is 'PayByTraffic'"
  default     = -1
}

variable "server_group_id" {
  description = "The ID of server group."
  default     = ""
}

variable "scheduler" {
  description = "Scheduling algorithm."
  default     = "wrr"
}

variable "healthy_threshold" {
  description = "Threshold determining the result of the health check is success."
  default     = 3
}

variable "unhealthy_threshold" {
  description = "Threshold determining the result of the health check is fail."
  default     = 3
}

variable "health_check_timeout" {
  description = "Maximum timeout of each health check response."
  default     = 5
}

variable "health_check_interval" {
  description = "Time interval of health checks."
  default     = 2
}

# HTTP and HTTPS listener variables
variable "enable_sticky_session" {
  description = "Whether to keep load balancer listener session."
  default     = false
}

variable "sticky_session_type" {
  description = "Listener sticky session type."
  default     = "server"
}

variable "cookie" {
  description = "Listener cookie."
  default     = ""
}

variable "cookie_timeout" {
  description = "Listener cookie timeout."
  default     = 86400
}

variable "enable_health_check" {
  description = "Whether to enable health check."
  default     = false
}

variable "enable_gzip" {
  description = "Whether to enable Gzip compress."
  default     = false
}

variable "retrive_slb_ip" {
  description = "Whether to use the XForwardedFor_SLBIP header to obtain the public IP address of the SLB instance."
  default     = false
}

variable "retrive_slb_id" {
  description = "Whether to use the XForwardedFor header to obtain the ID of the SLB instance."
  default     = false
}

variable "retrive_slb_proto" {
  description = " Whether to use the XForwardedFor_proto header to obtain the protocol used by the listener."
  default     = false
}

# TCP, HTTP and HTTPS listener variables
variable "health_check_connect_port" {
  description = "Port used for health check. Default to backend server port."
  default     = ""
}

variable "health_check_domain" {
  description = " Domain name used for health check."
  default     = ""
}

variable "health_check_uri" {
  description = "URI used for health check."
  default     = ""
}

variable "health_check_http_code" {
  description = "Regular health check HTTP status code. Multiple codes are segmented by ','."
  default     = "http_2xx"
}

# TCP listener variables
variable "health_check_type" {
  description = "Type of health check."
  default     = "tcp"
}

// TCP and UDP listener variables
variable "persistence_timeout" {
  description = "Timeout of connection persistence."
  default     = 0
}
