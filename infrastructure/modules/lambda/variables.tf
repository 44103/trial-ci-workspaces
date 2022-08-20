variable "commons" {}

variable "name" {
  description = "リソース名"
}

variable "envs" {
  description = "lambdaで使用する環境変数"
  default     = {}
}

locals {
  name = join("_", [
    var.commons.workspace,
    var.name,
    var.commons.service,
    var.commons.project
    ])
  envs = merge(
    { "TZ" = "Asia/Tokyo" },
    var.envs
  )
  func_dir = "${path.module}/../../functions/${var.name}"
  dist_dir = "${local.func_dir}/bootstrap"
}
