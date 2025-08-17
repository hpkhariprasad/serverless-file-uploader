variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"
}

variable "bucket_name" {
  description = "S3 bucket name (must be globally unique)"
  type        = string
  default     = "serverless-file-uploader-yourname"
}

variable "lambda_role_name" {
  description = "IAM role name for Lambda"
  type        = string
  default     = "lambda_s3_uploader_role"
}
