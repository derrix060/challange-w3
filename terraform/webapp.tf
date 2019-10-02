
variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 5000
}


provider "aws" {
  profile                 = "default"
  region                  = "ap-northeast-1"
}

output "lb_hostname" {
  value = aws_lb.main.dns_name
}
