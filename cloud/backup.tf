module "backup" {
  for_each = {
    git       = "tom.git"
    minecraft = "tom.25565"
    openclaw  = "tom.openclaw"
  }

  source = "./modules/backup"
  name   = each.key
  bucket = each.value
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

# https://opentofu.org/docs/language/values/outputs/
output "backup_openclaw_access_key_id" {
  value     = module.backup["openclaw"].access_key_id
  sensitive = true
}

# https://opentofu.org/docs/language/values/outputs/
output "backup_openclaw_secret_access_key" {
  value     = module.backup["openclaw"].secret_access_key
  sensitive = true
}
