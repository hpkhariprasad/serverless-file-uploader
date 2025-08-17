resource "aws_s3_bucket" "file_uploads" {
  bucket = var.bucket_name
  tags = { Project = "serverless-file-uploader", Environment = "dev" }
}

resource "aws_s3_bucket_public_access_block" "block" {
  bucket                  = aws_s3_bucket.file_uploads.id
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.file_uploads.id
  versioning_configuration { status = "Enabled" }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
  bucket = aws_s3_bucket.file_uploads.id
  rule {
    apply_server_side_encryption_by_default { sse_algorithm = "AES256" }
  }
}

# Optional: clean old test files after 7 days
resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
  bucket = aws_s3_bucket.file_uploads.id
  rule {
    id     = "expire-7-days"
    status = "Enabled"
    expiration { days = 7 }
    filter {}
  }
}
