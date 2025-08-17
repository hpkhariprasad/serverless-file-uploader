![Build & Test](https://github.com/hpkhariprasad/serverless-file-uploader/actions/workflows/ci-cd.yml/badge.svg?branch=main&event=push&job=build-test)
![Terraform Validate](https://github.com/hpkhariprasad/serverless-file-uploader/actions/workflows/ci-cd.yml/badge.svg?branch=main&event=push&job=terraform-validate)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](./LICENSE)

# 🚀 Serverless File Uploader

A **serverless file uploader** built with:
- AWS Lambda (.NET 8)
- Amazon S3
- Terraform (Infrastructure as Code)
- GitHub Actions (CI/CD)

---

## ✨ Features
- Upload files to S3 via Lambda
- Minimal IAM permissions
- Infrastructure managed via Terraform
- CI/CD pipeline with GitHub Actions
- Open-source friendly with Apache 2.0 license

---

## 🛠️ Tech Stack
- **.NET 8 Lambda** for backend
- **Terraform** for IaC
- **AWS S3** for storage
- **GitHub Actions** for CI/CD

---

## 📂 Project Structure

```bash
serverless-file-uploader/
├── .github/
│   └── workflows/
│       └── ci-cd.yml       # GitHub Actions pipeline (build, test, terraform validate)
│
├── src/
│   └── LambdaFileUploader/ # Lambda source code (.NET 8)
│       ├── Function.cs     # Main Lambda handler
│       └── *.csproj        # Project file
│
├── test/
│   └── LambdaFileUploader.Tests/  # Unit tests for Lambda
│       └── *.cs                   # Test cases
│
├── terraform/              # Terraform IaC
│   ├── main.tf             # Defines AWS Lambda + S3
│   ├── variables.tf        # Input variables
│   ├── outputs.tf          # Outputs (bucket name, etc.)
│   └── providers.tf        # AWS provider configuration
│
├── package.zip             # Lambda deployment package (generated during build)
├── README.md               # Project documentation
└── LICENSE                 # Open-source license (Apache 2.0)
```


## 🛠️ Setup Instructions
1. Prerequisites

AWS account with IAM access

Terraform installed

.NET 8 SDK installed

AWS CLI configured

2. Build & Package Lambda
cd src/LambdaFileUploader
dotnet publish -c Release -o ./publish

# Create zip for deployment (one level above terraform folder)
cd publish
zip -r ../../../package.zip .

3. Deploy Infrastructure with Terraform
cd terraform
terraform init
terraform apply


Terraform will:

Create an S3 bucket (serverless-file-uploader-<account_id>)

Deploy the Lambda function

Generate a public Lambda Function URL

▶️ Usage

After deployment, Terraform outputs a Lambda Function URL.

Send a POST request with a file stream to the Lambda URL. Example with curl:

curl -X POST \
     -H "Content-Type: application/octet-stream" \
     --data-binary "@sample.txt" \
     <LAMBDA_FUNCTION_URL>


The file will be uploaded into the configured S3 bucket.

📌 Real-World Extensions

Generate pre-signed URLs for direct client uploads.

Trigger post-processing (e.g., resize images, transcribe audio) using S3 Events + Lambda.

Add authentication with AWS Cognito or API Gateway.
