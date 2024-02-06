provider "aws" {
  region = var.region
}

module "lambda" {
  source = "./modules/lambda"
}

module "dynamodb" {
  source = "./modules/dynamodb"
}

module "api_gateway" {
  source = "./modules/api_gateway"
}

module "s3" {
  source = "./modules/s3"
}

module "cloudfront" {
  source = "./modules/cloudfront"
}

module "cognito" {
  source = "./modules/cognito"
}

module "lambda_authorizer" {
  source = "./modules/lambda_authorizer"
}

module "edge_lambda" {
  source = "./modules/edge_lambda"
}
