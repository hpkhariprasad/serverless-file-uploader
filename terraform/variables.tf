variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "S3 bucket name for uploads"
  type        = string
  default     = "my-serverless-file-uploader-bucket"
}
