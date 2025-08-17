resource "aws_s3_bucket" "file_uploads" {
  bucket = var.bucket_name

  tags = {
    Name        = "serverless-file-uploader"
    Environment = "dev"
  }
}

# Allow public block (recommended for uploads)
resource "aws_s3_bucket_public_access_block" "file_uploads" {
  bucket                  = aws_s3_bucket.file_uploads.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
