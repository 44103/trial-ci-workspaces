data "aws_caller_identity" "_" {}

module "vpc" {
  source  = "../modules/vpc"
  commons = local.commons
  name    = "sample"
}

module "lambda_hello_world" {
  source  = "../modules/lambda"
  commons = local.commons
  name    = "sample"
}
