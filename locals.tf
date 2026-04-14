locals {
  common_tags = {
    environment = terraform.workspace
  }
  suffix = substr(sha512(data.aws_caller_identity.current.account_id), 0, 8)
}

output "suffix" {
  value = local.suffix
}