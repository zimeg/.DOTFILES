# https://developer.hashicorp.com/terraform/language/settings/backends/s3
# https://opentofu.org/docs/language/v1-compatibility-promises#state-storage-backends

variable "state_bucket" {
  type     = string
  nullable = false
}

variable "state_lock_table" {
  type     = string
  nullable = false
}

variable "state_policy" {
  type     = string
  nullable = false
}

resource "aws_s3_bucket" "tf_state" {
  bucket = var.state_bucket
}

resource "aws_s3_bucket_ownership_controls" "tf_state_controls" {
  bucket = aws_s3_bucket.tf_state.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "tf_state_acl" {
  bucket     = aws_s3_bucket.tf_state.id
  acl        = "private"
  depends_on = [aws_s3_bucket_ownership_controls.tf_state_controls]

  lifecycle {
    ignore_changes = [acl]
  }
}

resource "aws_s3_bucket_versioning" "tf_state_versioning" {
  bucket = aws_s3_bucket.tf_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "dynamodb_tf_state_lock" {
  name           = var.state_lock_table
  read_capacity  = 2
  write_capacity = 2
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_iam_policy" "tofu_grocer" {
  name        = "tofu-deployment-grocer"
  description = "Permissions for managing deployment states"
  policy      = data.aws_iam_policy_document.tf_state_policy.json
}

data "aws_iam_policy_document" "tf_state_policy" {
  version = "2012-10-17"

  statement {
    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.tf_state.arn]
  }

  statement {
    actions   = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
    resources = ["${aws_s3_bucket.tf_state.arn}/*"]
  }

  statement {
    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem",
      "dynamodb:DescribeTable"
    ]
    resources = [aws_dynamodb_table.dynamodb_tf_state_lock.arn]
  }
}

