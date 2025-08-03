# https://github.com/LnL7/nix-darwin
{ pkgs, self, ... }@input:
{
  fonts = {
    packages = [
      pkgs.nerd-fonts._0xproto # https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/0xProto
    ];
  };
  nix = {
    enable = false; # https://github.com/zimeg/.DOTFILES/issues/28
  };
  nixpkgs = {
    hostPlatform = "aarch64-darwin";
  };
  security = {
    pam = {
      services = {
        sudo_local = {
          reattach = true;
          touchIdAuth = true;
        };
      };
    };
  };
  services = {
    # https://github.com/tailscale/tailscale
    tailscale = {
      enable = true;
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
      "ai/credentials" = {
        owner = input.config.users.users.ez.name;
        group = "wheel";
        format = "json";
        key = "";
        path = "/Users/ez/.local/share/crush/crush.json";
        sopsFile = ./programs/crush/credentials.json;
      };
      "netrc" = {
        owner = input.config.users.users.ez.name;
        group = "wheel";
        format = "binary";
        key = "";
        path = "/Users/ez/.netrc";
        sopsFile = ./programs/netrc/.netrc;
      };
      "puma/ssh/public" = {
        owner = input.config.users.users.ez.name;
        path = "/Users/ez/.ssh/id_ed25519.pub";
      };
      "puma/ssh/private" = {
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
