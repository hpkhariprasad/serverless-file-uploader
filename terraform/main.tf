# S3 Bucket
resource "aws_s3_bucket" "file_uploads" {
  bucket = var.bucket_name
  acl    = "private"

  tags = {
    Name        = "Serverless File Uploader"
    Environment = "Dev"
  }
}

# IAM Role for Lambda
resource "aws_iam_role" "lambda_role" {
  name = var.lambda_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "sts:AssumeRole",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# IAM Policy for S3 Access
resource "aws_iam_role_policy" "lambda_s3_policy" {
  name = "lambda_s3_policy"
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket"
        ],
        Resource = [
          aws_s3_bucket.file_uploads.arn,
          "${aws_s3_bucket.file_uploads.arn}/*"
        ]
      }
    ]
  })
}
