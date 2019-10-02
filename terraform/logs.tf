# logs.tf

# Set up CloudWatch group and log stream and retain logs for 30 days
resource "aws_cloudwatch_log_group" "awslogs-web-app" {
  name              = "awslogs-web-app"
  retention_in_days = 30

  tags = {
    Name = "awslogs-web-app-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "web-app_log_stream" {
  name           = "web-app_log_stream"
  log_group_name = aws_cloudwatch_log_group.awslogs-web-app.name
}


# Set up CloudWatch group and log stream and retain logs for 30 days
resource "aws_cloudwatch_log_group" "awslogs-redis" {
  name              = "awslogs-redis"
  retention_in_days = 30

  tags = {
    Name = "redis-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "redis_log_stream" {
  name           = "redis-log-stream"
  log_group_name = aws_cloudwatch_log_group.awslogs-redis.name
}