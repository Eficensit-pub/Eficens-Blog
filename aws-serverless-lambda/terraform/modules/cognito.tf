resource "aws_cognito_user_pool" "example" {
  name = "example_user_pool"
  // Add more configurations as needed
}

resource "aws_cognito_identity_provider" "example" {
  user_pool_id         = aws_cognito_user_pool.example.id
  provider_name        = "example_provider"
  provider_type        = "SAML"
  provider_details     = {
    metadata_url = "http://example.com/metadata"
  }
}
