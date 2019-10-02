
variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 5000
}
variable "region" {
  description = "AWS region"
  default     = "ap-northeast-1"
}


provider "aws" {
  version = "~> 2.30"
  profile = "default"
  region  = var.region
}


output "lb_hostname" {
  value = aws_lb.main.dns_name
}
