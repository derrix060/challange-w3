resource "aws_ecs_cluster" "main" {
  name = "cb-cluster"
}


resource "aws_iam_role" "app-service-role" {
  name = "app-service-role"

  assume_role_policy = <<EOF
{
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "1024"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "2048"
}

data "template_file" "app" {
  template = file("./terraform/app.json.tpl")

  vars = {
    app_image      = "alpine"
    app_port       = var.app_port
    fargate_cpu    = var.fargate_cpu
    fargate_memory = var.fargate_memory
  }
}


resource "aws_ecs_task_definition" "app" {
  family                   = "app-task"
  execution_role_arn       = aws_iam_role.app-service-role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  container_definitions    = data.template_file.app.rendered
}

resource "aws_ecs_service" "main" {
  name            = "web-app"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = aws_subnet.private.*.id
    assign_public_ip = true
  }


  load_balancer {
    target_group_arn = aws_lb_target_group.app.id
    container_name   = "web-app"
    container_port   = var.app_port
  }

  depends_on = [aws_iam_role_policy_attachment.ecs_task_execution_role]
}
