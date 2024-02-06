terraform {
required_providers {
aws = {
source  = "hashicorp/aws"
version = "~> 4.7"
}
}
}

provider "aws" {
region = var.aws_region
}

# ECS Cluster (shared by both environments)
module "ecs_cluster" {
source  = "./modules/ecs_cluster"
cluster_name = "my-ecs-cluster"
}

# Subnets and Security Groups (configure as needed)
variable "public_subnets" {
type = list(string)
}

variable "blue_security_group_ids" {
type = list(string)
}

variable "green_security_group_ids" {
type = list(string)
}

# Blue Environment
module "ecs_service_blue" {
source  = "./modules/ecs_service"
cluster_name = module.ecs_cluster.cluster_name
service_name = "blue-service"
task_definition_name = "blue-task-definition"
subnets = var.public_subnets
security_groups = var.blue_security_group_ids
# Define your image URI, environment variables, resources, etc.
}

# Green Environment
module "ecs_service_green" {
source  = "./modules/ecs_service"
cluster_name = module.ecs_cluster.cluster_name
service_name = "green-service"
task_definition_name = "green-task-definition"
subnets = var.public_subnets
security_groups = var.green_security_group_ids
# Define your image URI, environment variables, resources, etc.
}

# Optional: Route 53 configuration
module "route53" {
source  = "./modules/route53"
hosted_zone_id = "YOUR_HOSTED_ZONE_ID"
domain_name = "your-domain.com"
blue_service_endpoint = module.ecs_service_blue.endpoint
green_service_endpoint = module.ecs_service_green.endpoint
}
