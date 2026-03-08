# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "git" {
  bucket = "tom.git"
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls
resource "aws_s3_bucket_ownership_controls" "git" {
  bucket = aws_s3_bucket.git.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/s3_bucket_acl
resource "aws_s3_bucket_acl" "git" {
  bucket     = aws_s3_bucket.git.id
  acl        = "private"
  depends_on = [aws_s3_bucket_ownership_controls.git]

  lifecycle {
    ignore_changes = [acl]
  }
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block
resource "aws_s3_bucket_public_access_block" "git" {
  bucket = aws_s3_bucket.git.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/s3_bucket_versioning
resource "aws_s3_bucket_versioning" "git" {
  bucket = aws_s3_bucket.git.id

  versioning_configuration {
    status = "Enabled"
  }
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/s3_bucket_intelligent_tiering_configuration
resource "aws_s3_bucket_intelligent_tiering_configuration" "git" {
  bucket = aws_s3_bucket.git.id
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
resource "aws_iam_user" "git" {
  name = "git"
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/iam_access_key
resource "aws_iam_access_key" "git" {
  user = aws_iam_user.git.name
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/iam_policy
resource "aws_iam_policy" "git" {
  name = "git"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowListBucket"
        Effect = "Allow"
        Action = ["s3:ListBucket"]
        Resource = [
          "arn:aws:s3:::${aws_s3_bucket.git.id}"
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
          "arn:aws:s3:::${aws_s3_bucket.git.id}/*"
        ]
      }
    ]
  })
}

# https://search.opentofu.org/provider/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment
resource "aws_iam_user_policy_attachment" "git" {
  user       = aws_iam_user.git.name
  policy_arn = aws_iam_policy.git.arn
}

# https://opentofu.org/docs/language/values/outputs/
output "backup_git_access_key_id" {
  value     = aws_iam_access_key.git.id
  sensitive = true
}

# https://opentofu.org/docs/language/values/outputs/
output "backup_git_secret_access_key" {
  value     = aws_iam_access_key.git.secret
  sensitive = true
}
