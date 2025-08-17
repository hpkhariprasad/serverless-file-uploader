variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1" # Mumbai region
}

variable "lambda_function_name" {
  description = "Lambda function name"
  type        = string
  default     = "file-uploader-func"
}
