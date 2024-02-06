provider "aws" {
  region = var.region
}

module "lambda" {
  source = "./modules/lambda"

  function_name = var.lambda_function_name
  handler       = var.lambda_handler
  runtime       = var.lambda_runtime
  filename      = var.lambda_zip_file
}

module "dynamodb" {
  source = "./modules/dynamodb"

  table_name = var.dynamodb_table_name
}

module "api_gateway" {
  source = "./modules/api_gateway"

  api_gateway_name         = var.api_gateway_name
  api_gateway_resource_path = var.api_gateway_resource_path
}

module "s3" {
  source = "./modules/s3"

  bucket_name = var.s3_bucket_name
}

module "cloudfront" {
  source = "./modules/cloudfront"

  origin_domain  = var.cloudfront_origin_domain
  root_object    = var.cloudfront_root_object
}

module "cognito" {
  source = "./modules/cognito"

  user_pool_name              = var.cognito_user_pool_name
  identity_provider_name      = var.cognito_identity_provider_name
  identity_provider_type      = var.cognito_identity_provider_type
  identity_provider_metadata  = var.cognito_identity_provider_metadata_url
}

module "lambda_authorizer" {
  source = "./modules/lambda_authorizer"

  function_name = var.authorizer_lambda_function_name
  handler       = var.authorizer_handler
  runtime       = var.authorizer_runtime
  filename      = var.authorizer_zip_file
}

module "edge_lambda" {
  source = "./modules/edge_lambda"

  function_name = var.edge_lambda_function_name
  handler       = var.edge_lambda_handler
  runtime       = var.edge_lambda_runtime
  filename      = var.edge_lambda_zip_file
}
