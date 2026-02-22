# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

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

### Impermanence (tom only)

tom uses btrfs subvolumes (`root`, `nix`, `persistent`) with an ephemeral root recreated on each boot via `machines/tom/start.sh` in initrd. Old root snapshots are kept for 30 days. Directories/files that must survive reboots are declared in `environment.persistence."/persistent"` in `machines/tom/configuration.nix`.

### Secrets (sops-nix)

All secrets are age-encrypted YAML/JSON files under `machines/{name}/secrets/`. The age key location differs per OS: `/var/lib/sops-nix/key.txt` on NixOS (persisted through impermanence), `~/Library/Application Support/sops/age/keys.txt` on macOS. Secret declarations and path mappings live in each machine's `configuration.nix` under the `sops` attribute set.

Every secret must have explicit `owner` and `group`. Secrets are owned by the service user that reads them, not root. Each service runs as a dedicated user aligned per project (e.g., runner tokens owned by the runner user, minecraft secrets owned by `minecraft`). Only use root for secrets that genuinely require it (tailscale, SSH host keys, wireguard, password).

### CI

`versioning.yml` runs daily on self-hosted runners (tim then tom). It updates `flake.lock`, builds all darwin and NixOS configurations, and auto-merges to main on success.

### Cloud Proxy

The EC2 instance (`cloud/`) runs nginx as a reverse proxy with automatic ACME certificates. Public traffic arrives at the instance, terminates TLS, and forwards through a WireGuard tunnel to tom (`10.100.0.2`). Each proxied domain needs:

1. `cloud/proxy.tf` — Route53 A record pointing to the EC2 instance
2. `cloud/configuration.nix` — ACME cert entry and nginx virtualHost with proxyPass to tom's port
3. `machines/tom/configuration.nix` — TCP port in firewall `allowedTCPPorts`

For new top-level domains (not subdomains of existing zones), also add the zone ID to `cloud/tofu.auto.tfvars.json` under `proxy_hosted_zones`.

| Domain | Tom Port | Service |
|--------|----------|---------|
| api.o526.net | 8083 | endpoints |
| dev.o526.net | 3000 | blog preview |
| o526.net | 4321 | blog |
| quintus.sh | 5000 | quintus |
| todos.guide | 8082 | todos |

### GitHub Runners (tom)

Runner configuration lives in `machines/tom/services/github-runners/default.nix`. Each runner needs a corresponding secret declaration in `machines/tom/configuration.nix`.

**Multiple runners per repo:** Supported. Each runner needs a unique nix attribute name, unique GitHub `name`, and its own token. They can share user/group. The slacks repo uses 9 runners named after celestial bodies (mercury, venus, earth, mars, jupiter, saturn, uranus, neptune, pluto).

**Secret path conventions:**
- Single runner: `github/runners/{repo}` (e.g., `github/runners/blog`)
- Multiple runners: `github/runners/{repo}/{runner}` (e.g., `github/runners/slacks/mercury`)

**extraPackages:** Adds tools to the runner environment. Use this for CLI tools needed by workflows (e.g., `pkgs.gh` for GitHub CLI). The "self-hosted" label is added automatically.

**Polkit:** If a runner's workflow restarts a systemd service, add a polkit rule in `machines/tom/security/polkit/50-runners.rules` granting the runner's user permission to manage that unit. Runners use `NoNewPrivileges` which blocks sudo, so polkit is the only option.

### Systemd Services (tom)

Custom systemd services live in `machines/tom/systemd/services/`. Each service requires a corresponding user and group declared in `machines/tom/configuration.nix` under `users.users` and `users.groups`. Services with secrets also need sops declarations in the same file. Follow the pattern of existing services (snaek, tails, todos) when adding new ones.

### Polkit

Use polkit (not sudo) when services need to restart other services. GitHub runners set `NoNewPrivileges` internally via prctl, which blocks sudo regardless of systemd overrides. Polkit rules in `machines/tom/security/polkit/` grant specific users permission to manage specific units without privilege escalation.

### NixOS Privilege Escalation

- Sudo binary lives at `/run/wrappers/bin/sudo` (setuid wrapper, not in nix store)
- `security.sudo.execWheelOnly = true` restricts sudo execution to wheel group at filesystem level
- `pkgs.sudo` in extraPackages doesn't provide setuid - use full path to wrapper
- GitHub runners sandbox with `NoNewPrivileges`, `PrivateUsers`, `RestrictSUIDSGID` - these block sudo even with `serviceOverrides`

## Working Conventions

- Use `man configuration.nix` for NixOS option documentation instead of searching online.
- Never read files from the nix store.
- Use the Plan subagent for designing implementation approaches instead of the Explore subagent.
- Cloud infrastructure, tom, and tom's GitHub runners for repos are interconnected. Use existing patterns across these as reference when making changes.
