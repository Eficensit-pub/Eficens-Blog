resource "aws_ecs_task_definition" "task_definition" {
  family = var.task_definition_name
  # Define container definitions, memory, CPU, etc.
}

resource "aws_ecs_service" "service" {
  cluster = var.cluster_name
  name = var.service_name
  launch_type = "FARGATE"
  desired_count = 1
  task_definition = aws_ecs_task_definition.task_definition.arn
  network_configuration {
    subnets = var.subnets
    security_groups = var.security_groups
  }

  target_group_arn = aws_lb_target_group.target_group.arn
}

resource "aws_lb_target_group" "target_group" {
  name = var.service_name + "-target-group"
  protocol = "HTTP"
  port = 80
  target_type = "ECS"
  health_check {
    interval = 30
    timeout = 5
    path = "/health"
  }
}

output "endpoint" {
  value = aws_lb_target_group.target_group.arn
}
