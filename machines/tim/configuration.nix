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
        owner = "_github-runner";
        group = "_github-runner";
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
    users = {
      ez = {
        home = /Users/ez;
        name = "ez";
      };
    };
  };
}
