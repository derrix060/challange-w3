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
      ]
    },
    {
      "name": "redis",
      "image": "docker.io/library/redis:alpine",
      "cpu": 0,
      "portMappings": [
        {
          "containerPort": 6379,
          "hostPort": 6379
        }
      ]
    }
  ]