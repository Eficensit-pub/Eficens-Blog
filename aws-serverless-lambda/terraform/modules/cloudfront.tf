resource "aws_cloudfront_distribution" "example" {
  origin {
    domain_name = aws_s3_bucket.example.website_domain
    origin_id   = "S3-example"
  }

  default_cache_behavior {
    target_origin_id = "S3-example"
    viewer_protocol_policy = "redirect-to-https"
  }

  enabled             = true
  default_root_object = "index.html"
}
