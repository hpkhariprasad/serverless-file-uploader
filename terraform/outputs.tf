# -----------------------
# Outputs
# -----------------------

output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = aws_lambda_function.file_uploader.function_name
}

output "lambda_function_url" {
  description = "Invoke URL for Lambda function"
  value       = aws_lambda_function_url.file_uploader_url.function_url
}

output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.uploads.bucket
}
