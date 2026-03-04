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

resource "aws_kms_key" "secure" {
  description             = "this key is used to encrypt bucket objects"
  deletion_window_in_days = 9
}

resource "aws_s3_bucket_server_side_encryption_configuration" "secure" {
  bucket = aws_s3_bucket.secure.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.secure.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "logging" {
  bucket = "access-logging-${random_id.random.hex}"
  lifecycle {
    prevent_destroy = true
  }
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

data "aws_iam_policy_document" "topic" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }

    actions   = ["SNS:Publish"]
    resources = ["arn:aws:sns:*:*:s3-event-notification-topic"]

    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = [aws_s3_bucket.secure.arn]
    }
  }
}
resource "aws_sns_topic" "topic" {
  name   = "s3-event-notification-topic"
  policy = data.aws_iam_policy_document.topic.json
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.secure.id

  topic {
    topic_arn     = aws_sns_topic.topic.arn
    events        = ["s3:ObjectCreated:*"]
    filter_suffix = ".log"
  }
}


