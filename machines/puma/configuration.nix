# https://github.com/LnL7/nix-darwin
{ self, ... }@input:
{
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
      openai = {
        owner = input.config.users.users.ez.name;
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
