resource "aws_lambda_function" "example" {
  function_name    = "example_lambda_function"
  handler          = "index.handler"
  runtime          = "nodejs14.x"
  filename         = "path/to/your/lambda_function.zip"
  role             = aws_iam_role.lambda_role.arn
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"
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
