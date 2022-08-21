data "aws_caller_identity" "_" {}

module "vpc" {
  source  = "../modules/vpc"
  commons = local.commons
  name    = "sample"
}

module "lambda_greet" {
  source  = "../modules/lambda"
  commons = local.commons
  name    = "greet"
}

module "apigw" {
  source    = "../modules/apigw"
  commons   = local.commons
  name      = "trial"
  lambda    = module.lambda_greet
  path_part = "greet"
}
