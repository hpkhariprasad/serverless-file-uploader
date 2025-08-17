# -----------------------
# S3 Bucket for Uploads
# -----------------------
data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "uploads" {
  bucket = "serverless-file-uploader-${data.aws_caller_identity.current.account_id}"

  tags = {
    Name = "serverless-file-uploader"
  }
}

# Public Access Block
resource "aws_s3_bucket_public_access_block" "uploads" {
  bucket                  = aws_s3_bucket.uploads.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
