            # Bash script in deploy_lambda.sh
aws lambda create-function --function-name MyLambdaFunction \
    --runtime python3.8 \
    --role arn:aws:iam::123456789012:role/lambda-role \
    --handler lambda_function.lambda_handler \
    --zip-file fileb://lambda_code.zip
