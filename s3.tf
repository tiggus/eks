resource "random_id" "random" {
  keepers = {
    terraform_bucket = var.terraform_bucket
  }

  byte_length = 8
}

resource "aws_s3_bucket" "terraform" {
  bucket = "${var.terraform_bucket}-${random_id.random.hex}"
}
