resource "aws_s3_bucket" "terraform" {
  bucket = "terraform-state-123939393433434"

  tags = {
    Name        = "terraform"
    Environment = "dev"
  }
}