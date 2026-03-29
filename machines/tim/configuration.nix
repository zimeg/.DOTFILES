# https://github.com/LnL7/nix-darwin
{ pkgs, self, ... }@input:
{
  imports = [
    ../../programs/darwin
    ./programs/darwin
    ./services/github-runners
    ./services/openssh
    ./services/tailscale
  ];
  environment = {
    systemPackages = [
      pkgs.codex # https://github.com/openai/codex
      pkgs.fastfetch # https://github.com/fastfetch-cli/fastfetch
    ];
  };
  fonts = {
    packages = [
      pkgs.nerd-fonts._0xproto # https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/0xProto
    ];
  };
  nix = {
    enable = true; # https://github.com/zimeg/.DOTFILES/issues/28
    settings = {
      experimental-features = [
        "flakes"
        "nix-command"
      ];
    };
  };
  nixpkgs = {
    hostPlatform = "aarch64-darwin";
  };
  power = {
    restartAfterFreeze = true;
    restartAfterPowerFailure = true;
    sleep = {
      allowSleepByPowerButton = false;
      computer = "never";
      display = "never";
      harddisk = "never";
    };
  };
  sops = {
    defaultSopsFile = ./secrets/vault.yaml;
    defaultSopsFormat = "yaml";
    age = {
      generateKey = false;
      keyFile = "/Users/ez/Library/Application Support/sops/age/keys.txt";
      sshKeyPaths = [ ];
    };
    gnupg = {
      sshKeyPaths = [ ];
    };
    secrets = {
      "github/runners/dotfiles" = {
        group = "_github-runner";
        owner = "_github-runner";
        path = "/run/secrets/github/runners/dotfiles";
      };
      "github/accounts/theorderingmachine" = {
        key = "ssh/accounts/theorderingmachine/private";
        group = "_github-runner";
        owner = "_github-runner";
        path = "/run/secrets/github/accounts/theorderingmachine";
      };
      "ssh/accounts/theorderingmachine/private" = {
        owner = input.config.users.users.ez.name;
        path = "/Users/ez/.ssh/accounts/theorderingmachine";
      };
      "ssh/accounts/theorderingmachine/public" = {
        owner = input.config.users.users.ez.name;
        path = "/Users/ez/.ssh/accounts/theorderingmachine.pub";
      };
      "ssh/accounts/zimeg/private" = {
        owner = input.config.users.users.ez.name;
        path = "/Users/ez/.ssh/accounts/zimeg";
      };
      "ssh/accounts/zimeg/public" = {
        owner = input.config.users.users.ez.name;
        path = "/Users/ez/.ssh/accounts/zimeg.pub";
      };
      "ssh/default/private" = {
        key = "ssh/accounts/theorderingmachine/private";
        owner = input.config.users.users.ez.name;
        path = "/Users/ez/.ssh/id_ed25519";
      };
      "ssh/default/public" = {
        key = "ssh/accounts/theorderingmachine/public";
        owner = input.config.users.users.ez.name;
        path = "/Users/ez/.ssh/id_ed25519.pub";
      };
    };
  };
  system = {
    configurationRevision = self.rev or self.dirtyRev or null;
    stateVersion = 5;
  };
  users = {
    knownGroups = [ "_github-runner" ];
    knownUsers = [ "_github-runner" ];
    groups = {
      _github-runner = {
        gid = 533;
      };
    };
    users = {
      _github-runner = {
        createHome = false;
        gid = 533;
        home = "/private/var/lib/github-runners";
        name = "_github-runner";
        uid = 533;
      };
      ez = {
        home = /Users/ez;
        name = "ez";
      };
    };
  };
}
