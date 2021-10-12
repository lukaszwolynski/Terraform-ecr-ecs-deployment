resource "aws_ecs_cluster" "main" {
  name = "${var.prefix}-cluster"
}

resource "aws_ecs_task_definition" "main" {
  family = "service"
  memory = 512
  cpu    = 256
  container_definitions = jsonencode([
    {
      name      = "first"
      image     = var.imageRepository
      essential = true
      portMappings = [
        {
          containerPort = var.appPort
          hostPort      = var.appPort
        }
      ]
    },
  ])
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  #task_role_arn            = aws_iam_role.ecs_task_role
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
}

resource "aws_ecs_service" "main" {
  name                               = "${var.prefix}-service"
  cluster                            = aws_ecs_cluster.main.id
  task_definition                    = aws_ecs_task_definition.main.arn
  desired_count                      = 1
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200
  launch_type                        = "FARGATE"
  scheduling_strategy                = "REPLICA"

  network_configuration {
    security_groups  = [aws_security_group.allow_port.id]
    subnets          = var.subnets_id
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.main.arn
    container_name   = "first"
    container_port   = var.appPort
  }

  lifecycle {
    ignore_changes = [task_definition, desired_count]
  }
}

resource "aws_security_group" "allow_port" {
  name        = "allow_all"
  description = "Allow all trafic"
  ingress {
    from_port   = var.appPort
    to_port     = var.appPort
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
