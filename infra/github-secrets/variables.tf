variable "github_owner" {
  description = "GitHub user or organization that owns the repository."
  type        = string
  default     = "caffeineflo"
}

variable "github_repository" {
  description = "GitHub repository name."
  type        = string
  default     = "superman"
}

variable "sync_secret_values" {
  description = "Required GitHub Actions secrets for the sync workflow. Values are written to Terraform state; keep state private."
  type = object({
    IMDB_AUTH          = string
    IMDB_COOKIEATMAIN  = string
    SYNC_MODE          = string
    TRAKT_CLIENTID     = string
    TRAKT_CLIENTSECRET = string
    TRAKT_EMAIL        = string
    TRAKT_PASSWORD     = string
  })
  sensitive = true
}
