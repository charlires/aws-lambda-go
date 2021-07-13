terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "null_resource" "clean" {
  provisioner "local-exec" {
    command = "rm -r ./bin/main function.zip ./src/vendor || true"
  }
}

resource "null_resource" "go_build" {
  provisioner "local-exec" {
    command = "cd src && go mod -v vendor && GOOS=linux go build -mod vendor -o ../bin/main"
  }
  depends_on = [null_resource.clean]
}

# Zip the Lamda function on the fly
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "./bin/main"
  output_path = "./function.zip"
  depends_on  = [null_resource.go_build]
}

# resource "aws_cloudwatch_log_group" "cw_log_group" {
#   name              = "/aws/lambda/${aws_lambda_function.func.function_name}"
#   retention_in_days = 14
# }

# resource "aws_lambda_function" "func" {
#   filename         = data.archive_file.lambda_zip.output_path
#   source_code_hash = data.archive_file.lambda_zip.output_base64sha256
#   function_name    = "candonaegui-test-function"
#   role             = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole" // aws_iam_role.iam_for_lambda.arn
#   handler          = "main"
#   runtime          = "go1.x"
#   timeout          = 30 // seconds
#   depends_on       = [data.archive_file.lambda_zip]
# }

module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "candonaegui-test-function"
  #   description   = "My awesome lambda function"
  handler     = "main"
  runtime     = "go1.x"
  timeout     = 30 // seconds
  source_path = "./bin/main"

  tags = {
    Name = "my-lambda1"
  }
}
