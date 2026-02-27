resource "random_id" "random" {
  keepers = {
    terraform_bucket = var.terraform_bucket
  }

  byte_length = 8
}

resource "aws_s3_bucket" "terraform" {
  bucket = "${var.terraform_bucket}-${random_id.random.hex}"
}

resource "aws_s3_bucket" "secure" {
  bucket = "${var.secure_bucket}-${random_id.random.hex}"
}

resource "aws_s3_bucket_acl" "secure" {
  bucket = aws_s3_bucket.secure.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "secure" {
  bucket = aws_s3_bucket.secure.id
  versioning_configuration {
    status = "Enabled"
    mfa_delete = "Enabled"
  }
}

resource "aws_s3_bucket_logging" "secure" {
  bucket = aws_s3_bucket.secure.bucket

  target_bucket = aws_s3_bucket.logging.bucket
  target_prefix = "log/"
  target_object_key_format {
    partitioned_prefix {
      partition_date_source = "EventTime"
    }
  }
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "logging" {
  bucket = "access-logging-${random_id.random.hex}"
}

data "aws_iam_policy_document" "logging_bucket_policy" {
  statement {
    principals {
      identifiers = ["logging.s3.amazonaws.com"]
      type        = "Service"
    }
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.logging.arn}/*"]
    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }
  }
}

resource "aws_s3_bucket_policy" "logging" {
  bucket = aws_s3_bucket.logging.bucket
  policy = data.aws_iam_policy_document.logging_bucket_policy.json
}
