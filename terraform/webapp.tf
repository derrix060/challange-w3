
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

terraform {
  backend "s3" {
    encrypt = true
    bucket  = "mario-terraform-remote-state-storage"
    region  = "ap-northeast-1"
    key     = "aws-state"
  }
}

output "lb_hostname" {
  value = aws_lb.main.dns_name
}
