output "bucket_name" {
  value = aws_s3_bucket.file_uploads.bucket
}

output "iam_role_arn" {
  value = aws_iam_role.s3_upload_role.arn
}
