# GitHub Actions Secrets

This Terraform stack manages the required repository secrets for the `sync` workflow in `caffeineflo/superman`.

## What this solves

The workflow fails before syncing when GitHub has stale or wrong Trakt credentials. Managing the required secret names through Terraform makes the refresh repeatable and keeps the workflow contract in code.

Terraform still needs valid secret values. It can't create or rotate the Trakt OAuth application itself.

## State warning

The GitHub Terraform provider marks secret values as sensitive, but plaintext values are still stored in Terraform state. Keep `terraform.tfstate`, `*.tfvars`, and any backend state private. They are ignored by this repository.

## Apply

This stack has been staged on Proxmox at:

```sh
/rpool/dockerfs/terraform/superman-github-secrets
```

The existing required secrets have already been imported into Terraform state there. Run Terraform from that directory unless you intentionally want to bootstrap a new state.

Authenticate with GitHub first if you are running from a new machine:

```sh
gh auth login
```

Create a local `terraform.tfvars` from the example and fill in the current values. Do not apply the example placeholders.

```sh
cp terraform.tfvars.example terraform.tfvars
chmod 600 terraform.tfvars
$EDITOR terraform.tfvars
```

Apply the stack:

```sh
terraform init
terraform plan
terraform apply
```

Then run the workflow:

```sh
gh workflow run sync.yaml --repo caffeineflo/superman --ref main
```

## Required secrets

- `IMDB_AUTH`
- `IMDB_COOKIEATMAIN`
- `SYNC_MODE`
- `TRAKT_CLIENTID`
- `TRAKT_CLIENTSECRET`
- `TRAKT_EMAIL`
- `TRAKT_PASSWORD`

## Re-import

If the state is rebuilt somewhere else, import the existing GitHub secrets before applying:

```sh
for name in IMDB_AUTH IMDB_COOKIEATMAIN SYNC_MODE TRAKT_CLIENTID TRAKT_CLIENTSECRET TRAKT_EMAIL TRAKT_PASSWORD; do
  terraform import "github_actions_secret.sync[\"$name\"]" "superman:$name"
done
```
