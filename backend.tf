terraform {
  backend "s3" {
    bucket = "terraform-state-bbe7081d03a226fd"
    key    = "terraform"
    region = "us-east-1"
    encrypt = true
    use_lockfile = true
  }
}
