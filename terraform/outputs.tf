output "bucket_name" {
  description = "S3 bucket name"
  value       = aws_s3_bucket.file_uploads.bucket
}

output "lambda_role_arn" {
  description = "IAM role ARN for Lambda"
  value       = aws_iam_role.lambda_role.arn
}
