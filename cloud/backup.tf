# https://opentofu.org/docs/language/values/variables/
variable "import_minecraft_backup" {
  description = "Import existing minecraft backup resources (temporary)"
  type        = bool
  default     = false
}

locals {
  import_minecraft = var.import_minecraft_backup ? toset(["import"]) : toset([])
}

module "backup" {
  for_each = {
    git       = "tom.git"
    minecraft = "tom.25565"
  }

  source = "./modules/backup"
  name   = each.key
  bucket = each.value
}

# https://opentofu.org/docs/language/import/
# Temporary: import existing minecraft backup resources from the old state.
# Set import_minecraft_backup = true for the first apply, then remove these.
import {
  for_each = local.import_minecraft
  to       = module.backup["minecraft"].aws_s3_bucket.this
  id       = "tom.25565"
}

import {
  for_each = local.import_minecraft
  to       = module.backup["minecraft"].aws_s3_bucket_ownership_controls.this
  id       = "tom.25565"
}

import {
  for_each = local.import_minecraft
  to       = module.backup["minecraft"].aws_s3_bucket_acl.this
  id       = "tom.25565"
}

import {
  for_each = local.import_minecraft
  to       = module.backup["minecraft"].aws_s3_bucket_versioning.this
  id       = "tom.25565"
}

import {
  for_each = local.import_minecraft
  to       = module.backup["minecraft"].aws_s3_bucket_intelligent_tiering_configuration.this
  id       = "tom.25565,archives"
}

import {
  for_each = local.import_minecraft
  to       = module.backup["minecraft"].aws_iam_user.this
  id       = "minecraft"
}

import {
  for_each = local.import_minecraft
  to       = module.backup["minecraft"].aws_iam_policy.this
  id       = "arn:aws:iam::415471498952:policy/minecraft"
}

import {
  for_each = local.import_minecraft
  to       = module.backup["minecraft"].aws_iam_user_policy_attachment.this
  id       = "minecraft/arn:aws:iam::415471498952:policy/minecraft"
}

# https://opentofu.org/docs/language/values/outputs/
output "backup_git_access_key_id" {
  value     = module.backup["git"].access_key_id
  sensitive = true
}

# https://opentofu.org/docs/language/values/outputs/
output "backup_git_secret_access_key" {
  value     = module.backup["git"].secret_access_key
  sensitive = true
}

# https://opentofu.org/docs/language/values/outputs/
output "backup_minecraft_access_key_id" {
  value     = module.backup["minecraft"].access_key_id
  sensitive = true
}

# https://opentofu.org/docs/language/values/outputs/
output "backup_minecraft_secret_access_key" {
  value     = module.backup["minecraft"].secret_access_key
  sensitive = true
}

# https://opentofu.org/docs/language/modules/develop/refactoring/
moved {
  from = aws_s3_bucket.git
  to   = module.backup["git"].aws_s3_bucket.this
}

moved {
  from = aws_s3_bucket_ownership_controls.git
  to   = module.backup["git"].aws_s3_bucket_ownership_controls.this
}

moved {
  from = aws_s3_bucket_acl.git
  to   = module.backup["git"].aws_s3_bucket_acl.this
}

moved {
  from = aws_s3_bucket_public_access_block.git
  to   = module.backup["git"].aws_s3_bucket_public_access_block.this
}

moved {
  from = aws_s3_bucket_versioning.git
  to   = module.backup["git"].aws_s3_bucket_versioning.this
}

moved {
  from = aws_s3_bucket_intelligent_tiering_configuration.git
  to   = module.backup["git"].aws_s3_bucket_intelligent_tiering_configuration.this
}

moved {
  from = aws_iam_user.git
  to   = module.backup["git"].aws_iam_user.this
}

moved {
  from = aws_iam_access_key.git
  to   = module.backup["git"].aws_iam_access_key.this
}

moved {
  from = aws_iam_policy.git
  to   = module.backup["git"].aws_iam_policy.this
}

moved {
  from = aws_iam_user_policy_attachment.git
  to   = module.backup["git"].aws_iam_user_policy_attachment.this
}
