variable "common_values" {}
variable "name" {}

locals {
  name = join("_", [
    var.common_values.workspace,
    var.name,
    var.common_values.service,
    var.common_values.project
  ])
}
