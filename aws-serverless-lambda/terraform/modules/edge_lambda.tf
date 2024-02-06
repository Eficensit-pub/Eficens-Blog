resource "aws_cloudfront_distribution" "example" {
  origin {
    domain_name = aws_s3_bucket.example.website_domain
    origin_id   = "S3-example"
  }

  default_cache_behavior {
    target_origin_id = "S3-example"
    viewer_protocol_policy = "redirect-to-https"
    lambda_function_association {
      event_type   = "viewer-request"
      lambda_arn   = aws_lambda_function.edge_lambda.qualified_arn
      include_body = false
    }
  }

  enabled             = true
  default_root_object = "index.html"
}

resource "aws_lambda_function" "edge_lambda" {
  function_name    = "example_edge_lambda_function"
  handler          = "index.handler"
  runtime          = "nodejs14.x"
  filename         = "path/to/your/edge_lambda_function.zip"
  role             = aws_iam_role.edge_lambda_role.arn
}

resource "aws_iam_role" "edge_lambda_role" {
  name = "edge_lambda_execution_role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "lambda.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })

  // Add more policies if needed
}
