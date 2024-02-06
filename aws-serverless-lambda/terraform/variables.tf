# Lambda Module Variables
variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "example_lambda_function"
}

variable "lambda_handler" {
  description = "Handler for the Lambda function"
  type        = string
  default     = "index.handler"
}

variable "lambda_runtime" {
  description = "Runtime for the Lambda function"
  type        = string
  default     = "nodejs14.x"
}

variable "lambda_zip_file" {
  description = "Path to the ZIP file containing Lambda function code"
  type        = string
  default     = "path/to/your/lambda_function.zip"
}

# DynamoDB Module Variables
variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  type        = string
  default     = "example_table"
}

# API Gateway Module Variables
variable "api_gateway_name" {
  description = "Name of the API Gateway"
  type        = string
  default     = "example_api"
}

variable "api_gateway_resource_path" {
  description = "Path for the API Gateway resource"
  type        = string
  default     = "example"
}

# S3 Module Variables
variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "example-bucket"
}

# CloudFront Module Variables
variable "cloudfront_origin_domain" {
  description = "Domain name of the CloudFront origin (S3 bucket)"
  type        = string
  default     = aws_s3_bucket.example.website_domain
}

variable "cloudfront_root_object" {
  description = "Default root object for CloudFront distribution"
  type        = string
  default     = "index.html"
}

# Cognito Module Variables
variable "cognito_user_pool_name" {
  description = "Name of the Cognito User Pool"
  type        = string
  default     = "example_user_pool"
}

variable "cognito_identity_provider_name" {
  description = "Name of the Cognito Identity Provider"
  type        = string
  default     = "example_provider"
}

variable "cognito_identity_provider_type" {
  description = "Type of the Cognito Identity Provider"
  type        = string
  default     = "SAML"
}

variable "cognito_identity_provider_metadata_url" {
  description = "Metadata URL for the Cognito Identity Provider"
  type        = string
  default     = "http://example.com/metadata"
}

# Lambda Authorizer Module Variables
variable "authorizer_lambda_function_name" {
  description = "Name of the Lambda function for authorizer"
  type        = string
  default     = "example_authorizer_lambda_function"
}

variable "authorizer_handler" {
  description = "Handler for the Lambda function for authorizer"
  type        = string
  default     = "index.handler"
}

variable "authorizer_runtime" {
  description = "Runtime for the Lambda function for authorizer"
  type        = string
  default     = "nodejs14.x"
}

variable "authorizer_zip_file" {
  description = "Path to the ZIP file containing Lambda function code for authorizer"
  type        = string
  default     = "path/to/your/authorizer_function.zip"
}

# Edge Lambda Module Variables
variable "edge_lambda_function_name" {
  description = "Name of the Lambda function for CloudFront edge"
  type        = string
  default     = "example_edge_lambda_function"
}

variable "edge_lambda_handler" {
  description = "Handler for the Lambda function for CloudFront edge"
  type        = string
  default     = "index.handler"
}

variable "edge_lambda_runtime" {
  description = "Runtime for the Lambda function for CloudFront edge"
  type        = string
  default     = "nodejs14.x"
}

variable "edge_lambda_zip_file" {
  description = "Path to the ZIP file containing Lambda function code for CloudFront edge"
  type        = string
  default     = "path/to/your/edge_lambda_function.zip"
}
