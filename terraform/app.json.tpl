[
    {
      "name": "web-app",
      "image": "${app_image}",
      "cpu": ${fargate_cpu},
      "memory": ${fargate_memory},
      "networkMode": "awsvpc",
      "portMappings": [
        {
          "containerPort": ${app_port},
          "hostPort": ${app_port}
        }
      ]
    },
    {
      "name": "w3-redis",
      "image": "docker.io/library/redis:alpine",
      "cpu": ${fargate_cpu},
      "memory": ${fargate_memory},
      "networkMode": "awsvpc",
      "portMappings": [
        {
          "containerPort": 6379,
          "hostPort": 6379
        }
      ]
    }
  ]