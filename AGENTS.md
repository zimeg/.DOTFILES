# AGENTS.md

This file provides guidance to coding agents when working with code in this repository.

## Overview

This repository is a Nix flake that manages:
- `tom`: a NixOS desktop/server with impermanence, self-hosted services, and GitHub runners
- `puma`, `tim`, and `work`: macOS machines managed with `nix-darwin`
- shared user tooling through Home Manager in `programs/`
- cloud infrastructure for the public reverse proxy in `cloud/` using OpenTofu

## Key Entry Points

- `flake.nix` - Wires inputs, machine outputs, Home Manager, and shared modules together
- `programs/home.nix` - Shared Home Manager packages and imports used on every machine
- `machines/{name}/configuration.nix` - System-level machine configuration
- `machines/{name}/home.nix` - Machine-specific Home Manager overrides
- `machines/{name}/services/` - Machine-local service modules
- `machines/{name}/programs/` - Machine-local program overrides
- `cloud/` - AWS/OpenTofu configuration for the public proxy instance

## Change Map

- Shared shell/editor/tooling changes usually start in `programs/` or `programs/home.nix`
- Machine-specific OS changes belong in `machines/{name}/configuration.nix` or an imported module under that machine
- Machine-specific user changes belong in `machines/{name}/home.nix` or `machines/{name}/programs/`
- Public internet routing changes usually require coordinated updates in `cloud/` and `machines/tom/configuration.nix`
- New long-running services on `tom` typically need a systemd service, a dedicated user/group, firewall review, and possibly a sops secret
- GitHub runner changes often span runner module config, secrets, and polkit permissions

## Build Commands

**NixOS (tom):**
```bash
sudo nixos-rebuild switch --flake .#tom        # apply system changes
nix build .#nixosConfigurations.tom.config.system.build.toplevel  # build without applying
```

**macOS (darwin):**
```bash
sudo darwin-rebuild switch --flake .#"$(hostname)"  # apply system changes
nix build .#darwinConfigurations.ezmbp24.local.system       # build puma
nix build .#darwinConfigurations.eztim25.local.system       # build tim
nix build .#darwinConfigurations.edenzim-ltmbn8v.internal.salesforce.com.system  # build work
```

**Cloud infrastructure:**
```bash
nix develop          # enter shell with opentofu
./cloud.sh plan      # preview changes
./cloud.sh apply     # deploy
```

**Secrets:**
```bash
sops machines/tom/secrets/vault.yaml   # edit encrypted secrets (requires age key)
```

**Services (tom):**
```bash
journalctl -u <service> -n 50          # recent logs
journalctl -u <service> -f             # follow logs
systemctl status <service>             # service status
systemctl restart <service>            # restart service
```

## Architecture

This is a Nix flake managing four machines with Home Manager, sops-nix for secrets, and impermanence for ephemeral root on NixOS.

### Machines

| Machine | Hostname | OS | Notes |
|---------|----------|----|-------|
| tom | tom | NixOS (x86_64-linux) | Desktop/server, NVIDIA GPU, impermanence, Plasma 6 |
| puma | ezmbp24.local | macOS (aarch64-darwin) | Personal laptop |
| tim | eztim25.local | macOS (aarch64-darwin) | Home server, GitHub runners |
| work | edenzim-ltmbn8v.internal.salesforce.com | macOS (aarch64-darwin) | Work laptop |

### Configuration Layers

- `flake.nix` - Defines all inputs, machine outputs, and wires modules together. Each machine gets `configuration.nix` (system), `home.nix` (machine-specific user config), and `programs/home.nix` (shared user config).
- `programs/home.nix` - Shared Home Manager config imported by every machine. Contains languages, LSPs, formatters, and program module imports (neovim, zsh, tmux, git, etc.).
- `machines/{name}/home.nix` - Machine-specific Home Manager overrides. Imports from `programs/` for shared configs, from `machines/{name}/programs/` for local overrides.
- `machines/{name}/configuration.nix` - System-level NixOS/darwin config. Imports from `machines/{name}/services/`, `security/`, `hardware/`, etc.

### How Config Flows

- `flake.nix` is the root composition layer and selects which modules apply to each machine
- System behavior is mostly split into imported modules below each machine directory
- Shared userland tools and program config are centralized in `programs/`
- Secrets are declared in machine `configuration.nix` files and materialized by `sops-nix`
- `cloud/configuration.nix` builds the EC2 image, while `cloud/*.tf` provisions the AWS resources around it

### Impermanence (tom only)

tom uses btrfs subvolumes (`root`, `nix`, `persistent`) with an ephemeral root recreated on each boot via `machines/tom/start.sh` in initrd. Old root snapshots are kept for 30 days. Directories/files that must survive reboots are declared in `environment.persistence."/persistent"` in `machines/tom/configuration.nix`.

**DynamicUser conflict:** NixOS services with `DynamicUser=true` store state in `/var/lib/private/{service}` (symlinked from `/var/lib/{service}`). Impermanence bind mounts on `/var/lib/{service}` conflict with this, causing "Device or resource busy". Fix by either persisting `/var/lib/private/{service}` or switching to a static user with `DynamicUser = lib.mkForce false`.

### Secrets (sops-nix)

All secrets are age-encrypted YAML/JSON files under `machines/{name}/secrets/`. The age key location differs per OS: `/var/lib/sops-nix/key.txt` on NixOS (persisted through impermanence), `~/Library/Application Support/sops/age/keys.txt` on macOS. Secret declarations and path mappings live in each machine's `configuration.nix` under the `sops` attribute set.

Every secret must have explicit `owner` and `group`. Secrets are owned by the service user that reads them, not root. Each service runs as a dedicated user aligned per project (e.g., runner tokens owned by the runner user, minecraft secrets owned by `minecraft`). Only use root for secrets that genuinely require it (tailscale, SSH host keys, wireguard, password).

### CI

`versioning.yml` runs daily on self-hosted runners (tim then tom). It updates `flake.lock`, builds all darwin and NixOS configurations, and auto-merges to main on success.

### Cloud Proxy

The EC2 instance (`cloud/`) runs nginx as a reverse proxy with automatic ACME certificates. Public traffic arrives at the instance, terminates TLS, and forwards through a WireGuard tunnel to tom (`10.100.0.2`). Each proxied domain needs:

1. `cloud/proxy.tf` — Route53 A record pointing to the EC2 instance
2. `cloud/configuration.nix` — ACME cert entry and nginx virtualHost with proxyPass to tom's port, plus the port in `allowedTCPPorts`
3. `machines/tom/configuration.nix` — TCP port in firewall `allowedTCPPorts`

For new top-level domains (not subdomains of existing zones), also add the zone ID to `cloud/tofu.auto.tfvars.json` under `proxy_hosted_zones`.

| Domain | Tom Port | Service |
|--------|----------|---------|
| api.o526.net | 8083 | endpoints |
| dev.o526.net | 3000 | blog preview |
| git.o526.net | 23231 (SSH stream) | soft-serve |
| o526.net | 4321 | blog |
| quintus.sh | 5000 | quintus |
| todos.guide | 8082 | todos |
| tom.o526.net | 25565 (TCP stream) | minecraft |

**TCP stream proxying:** For non-HTTP services (like git SSH or Minecraft), use nginx `streamConfig` with TCP forwarding instead of ACME/virtualHost. The cloud proxy forwards the port directly to tom over WireGuard. This requires a security group ingress rule and Route53 record in `cloud/proxy.tf`, but no ACME cert or virtualHost.

### GitHub Runners (tom)

Runner configuration lives in `machines/tom/services/github-runners/default.nix`. Each runner needs a corresponding secret declaration in `machines/tom/configuration.nix`.

**Multiple runners per repo:** Supported. Each runner needs a unique nix attribute name, unique GitHub `name`, and its own token. They can share user/group. The slacks repo uses 9 runners named after celestial bodies (mercury, venus, earth, mars, jupiter, saturn, uranus, neptune, pluto).

**nix-darwin custom runner users:** If a darwin runner should run as a dedicated user/group instead of the default `_github-runner`, declare the user in `users.users`, the group in `users.groups`, add both names to `users.knownUsers` and `users.knownGroups`, and set explicit `uid`/`gid` on the user plus the matching group `gid`. Without that, activation can fail with missing option errors or `chown: invalid user`.

**Secret path conventions:**
- Single runner: `github/runners/{repo}` (e.g., `github/runners/blog`)
- Multiple runners: `github/runners/{repo}/{runner}` (e.g., `github/runners/slacks/mercury`)

**extraPackages:** Adds tools to the runner environment. Use this for CLI tools needed by workflows (e.g., `pkgs.gh` for GitHub CLI). The "self-hosted" label is added automatically.

**Polkit:** If a runner's workflow restarts a systemd service, add a polkit rule in `machines/tom/security/polkit/50-runners.rules` granting the runner's user permission to manage that unit. Runners use `NoNewPrivileges` which blocks sudo, so polkit is the only option.

### Systemd Services (tom)

Custom systemd services live in `machines/tom/systemd/services/`. Each service requires a corresponding user and group declared in `machines/tom/configuration.nix` under `users.users` and `users.groups`. Services with secrets also need sops declarations in the same file. Follow the pattern of existing services (snaek, tails, todos) when adding new ones.

**Non-root services using `nix run`** need a writable cache directory. Set `CacheDirectory = "{service}"` in `serviceConfig` and `HOME`/`XDG_CACHE_HOME` to `/var/cache/{service}` in `environment`. Without this, `nix run` fails because the user has no home or cache path.

**Privileged ports** (below 1024) require `AmbientCapabilities = [ "CAP_NET_BIND_SERVICE" ]` in `serviceConfig` when the service runs as a non-root user.

### Polkit

Use polkit (not sudo) when services need to restart other services. GitHub runners set `NoNewPrivileges` internally via prctl, which blocks sudo regardless of systemd overrides. Polkit rules in `machines/tom/security/polkit/` grant specific users permission to manage specific units without privilege escalation.

### NixOS Privilege Escalation

- Sudo binary lives at `/run/wrappers/bin/sudo` (setuid wrapper, not in nix store)
- `security.sudo.execWheelOnly = true` restricts sudo execution to wheel group at filesystem level
- `pkgs.sudo` in extraPackages doesn't provide setuid - use full path to wrapper
- GitHub runners sandbox with `NoNewPrivileges`, `PrivateUsers`, `RestrictSUIDSGID` - these block sudo even with `serviceOverrides`

### Soft Serve (tom)

SSH-only git server at `machines/tom/services/soft-serve/`. Runs as static user `git` (not DynamicUser) on port 23231. Cloud proxy forwards port 22 → tom:23231 via nginx TCP stream. Key quirks:
- `initial_admin_keys` only applies on first DB init — wipe `/var/lib/soft-serve` to re-initialize
- NixOS module sets `UMask = "0027"` stripping execute from hooks — override with `lib.mkForce "0022"`
- Use `--sync-hooks` flag to fix stale nix store paths after rebuilds
- Restic backups to S3 bucket `tom.git`

## Working Conventions

- Prefer orienting from `flake.nix` first, then the relevant machine `configuration.nix`, then imported modules.
- Use `man configuration.nix` for NixOS option documentation instead of searching online.
- Never read files from the nix store.
- For custom darwin service accounts, reserve stable local IDs and document them in config. `dotfiles` on `tim` uses UID/GID `534`; pick the next unused ID for future dedicated darwin users/groups instead of reusing generic accounts.
- Shared Home Manager git config explicitly sets `programs.git.signing.format = null;`. Treat unsigned commits as the current default until machine-specific signing is configured intentionally.
- Use the Plan subagent for designing implementation approaches instead of the Explore subagent.
- Cloud infrastructure, tom, and tom's GitHub runners for repos are interconnected. Use existing patterns across these as reference when making changes.
- Maintain alphabetical ordering throughout config files: imports, firewall ports, security groups, Route53 records, nginx streams, users/groups.
