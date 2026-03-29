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
        owner = "dotfiles";
        group = "dotfiles";
      };
      "github/ssh" = {
        key = "ssh/private";
        owner = "dotfiles";
        group = "dotfiles";
      };
      "ssh/public" = {
        owner = input.config.users.users.ez.name;
        path = "/Users/ez/.ssh/id_ed25519.pub";
      };
      "ssh/private" = {
        owner = input.config.users.users.ez.name;
        path = "/Users/ez/.ssh/id_ed25519";
      };
    };
  };
  system = {
    configurationRevision = self.rev or self.dirtyRev or null;
    stateVersion = 5;
  };
  users = {
    knownGroups = [ "dotfiles" ];
    knownUsers = [ "dotfiles" ];
    groups = {
      dotfiles = {
        gid = 534;
      };
    };
    users = {
      dotfiles = {
        createHome = true;
        gid = 534;
        home = "/private/var/lib/dotfiles";
        name = "dotfiles";
        uid = 534;
      };
      ez = {
        home = /Users/ez;
        name = "ez";
      };
    };
  };
}
