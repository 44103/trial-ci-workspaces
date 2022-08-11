resource "aws_vpc" "main" {
  tags = {
    Name = local.name
  }
}
