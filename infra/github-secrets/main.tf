provider "github" {
  owner = var.github_owner
}

locals {
  sync_secret_names = toset([
    "IMDB_AUTH",
    "IMDB_COOKIEATMAIN",
    "SYNC_MODE",
    "TRAKT_CLIENTID",
    "TRAKT_CLIENTSECRET",
    "TRAKT_EMAIL",
    "TRAKT_PASSWORD",
  ])

  sync_secret_values = {
    IMDB_AUTH          = var.sync_secret_values.IMDB_AUTH
    IMDB_COOKIEATMAIN  = var.sync_secret_values.IMDB_COOKIEATMAIN
    SYNC_MODE          = var.sync_secret_values.SYNC_MODE
    TRAKT_CLIENTID     = var.sync_secret_values.TRAKT_CLIENTID
    TRAKT_CLIENTSECRET = var.sync_secret_values.TRAKT_CLIENTSECRET
    TRAKT_EMAIL        = var.sync_secret_values.TRAKT_EMAIL
    TRAKT_PASSWORD     = var.sync_secret_values.TRAKT_PASSWORD
  }
}

resource "github_actions_secret" "sync" {
  for_each = local.sync_secret_names

  repository  = var.github_repository
  secret_name = each.key
  value       = local.sync_secret_values[each.key]
}
