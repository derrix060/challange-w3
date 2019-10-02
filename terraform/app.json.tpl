[
    {
      "name": "web-app",
      "image": "${app_image}",
      "cpu": 0,
      "portMappings": [
        {
          "containerPort": ${app_port},
          "hostPort": ${app_port}
        }
      ],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
            "awslogs-group": "awslogs-web-app",
            "awslogs-region": "${region}",
            "awslogs-stream-prefix": "awslogs-web-app-stream"
        }
      }
    },
    {
      "name": "w3-redis",
      "image": "docker.io/library/redis:alpine",
      "cpu": 0,
      "portMappings": [
        {
          "containerPort": 6379,
          "hostPort": 6379
        }
      ],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
            "awslogs-group": "awslogs-redis",
            "awslogs-region": "${region}",
            "awslogs-stream-prefix": "awslogs-redis-stream"
        }
      }
    }
  ]