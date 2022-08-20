data "aws_caller_identity" "_" {}

module "vpc" {
  commons = local.commons
  source  = "../modules/vpc"
  name    = "sample"
}
