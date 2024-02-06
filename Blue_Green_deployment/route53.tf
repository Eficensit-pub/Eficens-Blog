resource "aws_route53_record" "blue_alias" {
  zone_id = var.hosted_zone_id
  name = var.domain_name
  type = "A"
  alias {
    name = module.ecs_service_blue.endpoint
    zone_id = aws_ecs_service_blue.endpoint.zone_id
  }
}

resource "aws_route53_record" "green_alias" {
  zone_id = var.hosted_zone_id
  name = var.domain_name
  type = "A"
  alias {
    name = module.ecs_service_green.endpoint
    zone_id = aws_ecs_service_green.endpoint.zone_id
  }
