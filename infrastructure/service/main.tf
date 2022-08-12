data "aws_caller_identity" "_" {}

module "vpc" {
  common_values = local.common_values
  source        = "../modules/vpc"
  name          = "sample"
}
