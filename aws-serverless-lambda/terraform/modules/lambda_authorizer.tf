resource "aws_lambda_function" "authorizer" {
  function_name    = "example_authorizer_lambda_function"
  handler          = "index.handler"
  runtime          = "nodejs14.x"
  filename         = "path/to/your/authorizer_function.zip"
  role             = aws_iam_role.authorizer_role.arn
}

resource "aws_iam_role" "authorizer_role" {
  name = "authorizer_execution_role"
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
