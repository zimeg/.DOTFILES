# https://opentofu.org/docs/language/values/variables/
variable "name" {
  type     = string
  nullable = false
}

# https://opentofu.org/docs/language/values/variables/
variable "bucket" {
  type     = string
  nullable = false
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "this" {
  bucket = var.bucket
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls
resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/s3_bucket_acl
resource "aws_s3_bucket_acl" "this" {
  bucket     = aws_s3_bucket.this.id
  acl        = "private"
  depends_on = [aws_s3_bucket_ownership_controls.this]

  lifecycle {
    ignore_changes = [acl]
  }
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block
resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/s3_bucket_versioning
resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = "Enabled"
  }
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/s3_bucket_intelligent_tiering_configuration
resource "aws_s3_bucket_intelligent_tiering_configuration" "this" {
  bucket = aws_s3_bucket.this.id
  name   = "archives"

  tiering {
    access_tier = "ARCHIVE_ACCESS"
    days        = 90
  }

  tiering {
    access_tier = "DEEP_ARCHIVE_ACCESS"
    days        = 180
  }
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/iam_user
resource "aws_iam_user" "this" {
  name = var.name
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/iam_access_key
resource "aws_iam_access_key" "this" {
  user = aws_iam_user.this.name
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/iam_policy
resource "aws_iam_policy" "this" {
  name = var.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowListBucket"
        Effect = "Allow"
        Action = ["s3:ListBucket"]
        Resource = [
          "arn:aws:s3:::${aws_s3_bucket.this.id}"
        ]
      },
      {
        Sid    = "AllowSpecificObject"
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
        ]
        Resource = [
          "arn:aws:s3:::${aws_s3_bucket.this.id}/*"
        ]
      }
    ]
  })
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment
resource "aws_iam_user_policy_attachment" "this" {
  user       = aws_iam_user.this.name
  policy_arn = aws_iam_policy.this.arn
}

# https://opentofu.org/docs/language/values/outputs/
output "access_key_id" {
  value     = aws_iam_access_key.this.id
  sensitive = true
}

# https://opentofu.org/docs/language/values/outputs/
output "secret_access_key" {
  value     = aws_iam_access_key.this.secret
  sensitive = true
}
