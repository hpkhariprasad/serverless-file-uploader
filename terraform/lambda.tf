# -----------------------
# Lambda Function
# -----------------------
resource "aws_lambda_function" "file_uploader" {
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_role.arn
  handler       = "LambdaFileUploader::LambdaFileUploader.Function::FunctionHandler"
  runtime       = "dotnet8"

  # zip file should be one level above terraform folder
  filename         = "../package.zip"
  source_code_hash = filebase64sha256("../package.zip")
  timeout = 30   # ✅ increase timeout from default 3s to 30s
  memory_size = 512 # optional, increase memory for faster execution

  environment {
    variables = {
      BUCKET_NAME   = aws_s3_bucket.uploads.bucket
      APP_REGION    = var.aws_region # ✅ safe custom key instead of AWS_REGION
    }
  }

  lifecycle {
    ignore_changes = [role, environment]
  }
}

# -----------------------
# Lambda Function URL (direct HTTPS endpoint)
# -----------------------
resource "aws_lambda_function_url" "file_uploader_url" {
  function_name      = aws_lambda_function.file_uploader.function_name
  authorization_type = "NONE"
}
