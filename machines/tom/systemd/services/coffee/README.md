# maintainers.coffee on TOM

This prepares opt-in production and staging services, following the blog/quintus
`nix run` pattern and the EC2 nginx → WireGuard → TOM proxy. Application compute
is self-hosted on TOM; the public TLS gateway still runs on AWS EC2 (this is not
an all-local hosting setup). Both application services and cloud virtual hosts
are **disabled by default**. No deployment,
DNS change, runner permissions or encrypted placeholder secrets are included.

| Environment | Origin | TOM listener | Runtime account |
| --- | --- | --- | --- |
| production | https://maintainers.coffee | 10.100.0.2:8084 | coffee-production |
| staging | https://dev.maintainers.coffee | 10.100.0.2:8085 | coffee-staging |

## Activation prerequisites (separate reviewed change)

1. Publish and verify the app's `packages.default` and `apps.default` entry points
   in `maintainersdotcoffee/shop`. Pin each environment's `revision` to a reviewed
   full commit SHA, not a moving `main` or feature branch. Promote the tested
   staging commit to production explicitly. The packaging must run from an
   immutable store installation without writing into its source directory.
2. Create two **real** age-encrypted dotenv files using TOM's existing SOPS
   recipients and stage them in Git. Do not print or commit plaintext. Each file
   needs `GITHUB_CLIENT_ID`, `GITHUB_CLIENT_SECRET`, `STRIPE_SECRET_KEY`, and an
   independently generated `SESSION_SECRET` of at least 32 characters. Use a
   separate GitHub OAuth application for each environment, with callbacks:
   - `https://maintainers.coffee/auth/github/callback`
   - `https://dev.maintainers.coffee/auth/github/callback`
   Staging must use a Stripe test-mode `sk_test_` key; production uses `sk_live_`.
   The shop repository is currently private. Each runtime environment also needs
   its own least-privilege, read-only GitHub repository token in the encrypted
   `NIX_CONFIG` variable (`access-tokens = github.com=...`) so `nix run` can fetch
   the pinned app. Do not reuse the CI runner token or an operator's broad token,
   put this value in the public Nix `environment`, or log it. Alternatively,
   making the app source public removes this retrieval prerequisite. Verify
   retrieval as each runtime user before activation; an operator's `gh` login
   does not authorize the service account.
   Do not put routing variables in these files: the module sets `APP_ENV`,
   `APP_ORIGIN`, `HOST`, `PORT` and `NODE_ENV=production`. The app must validate
   complete auth configuration and reject incorrect Stripe modes at startup.
3. Configure `services.maintainers-coffee.{production,staging}` in a TOM module:
   set `enable = true`, `revision` to the verified commit, and `sopsFile` to the
   appropriate encrypted file. Each service gets its own user/group, cache,
   persisted state, and `0400` secret leaf `coffee/<environment>/env`. The
   existing `coffee` account remains a CI runner and cannot read these files.
   Ports open only on `wg0`; no EC2 inbound app ports are needed. A required
   `EnvironmentFile` prevents startup without materialized secrets. Operators,
   not the runner, control activation/restarts; no new polkit grants are added.
4. Coordinate DNS and TLS cutover before enabling cloud
   `services.maintainers-coffee-proxy.{production,staging}.enable`. These options
   live in `cloud/coffee.nix`; set them from `cloud/configuration.nix`. HTTP-01
   certificates require DNS to reach the EC2 proxy. Test staging over HTTPS
   first, including GitHub login, Stripe test account creation, and invalid
   OAuth state/cookie behavior. Only then schedule the production cutover.

## DNS ownership / rollback

`shop/infra/route53.tf` owns `aws_route53_zone.maintainers` and its records;
`shop/infra/modules/dyno/main.tf` owns the current production and staging
CloudFront alias records. `shop/infra/cdn.tf` independently owns
`src.maintainers.coffee`. The hosted zone is not a literal ID in the app's
variable definitions, and it is not listed in this repo's cloud tfvars.

Keep all of these resources and the Heroku/CDN infrastructure unchanged here.
Do not add overlapping Route53 resources to `.DOTFILES`' separate Terraform
state. A future DNS cutover should modify the records in their existing owner
state, or explicitly remove/import ownership with reviewed state backups.
Retain the current routing targets and infrastructure for rollback; undo the
record change and disable the new app/proxy if validation fails. Never run
`tofu apply` just to test this preparation.

## Verification without activation

Stage new files before evaluation (Git-backed flakes ignore untracked files):

```sh
nix eval --json .#nixosConfigurations.tom.config.services.maintainers-coffee
nix eval --impure --json --file tests/coffee.nix
nix build .#nixosConfigurations.tom.config.system.build.toplevel --no-link
git diff --cached --check
```

The evaluation tests use two existing encrypted files **only as path/type
fixtures** and an existing shop commit **only as a source-string fixture**.
They never decrypt, start, or build the enabled fixture services; those files
are not coffee credentials and that commit is not a deployment recommendation.
The full toplevel build uses the actual disabled-by-default configuration.
