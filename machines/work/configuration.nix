# https://github.com/LnL7/nix-darwin
{ self, pkgs, ... }@input:
{
  environment = {
    systemPackages = [
      pkgs.code-cursor # https://github.com/getcursor/cursor
      pkgs.google-cloud-sdk # https://github.com/GoogleCloudPlatform/cloud-sdk-docker
      pkgs.vscode # https://github.com/microsoft/vscode
    ];
  };
  nix = {
    enable = false; # https://github.com/zimeg/.DOTFILES/issues/28
  };
  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config = {
      allowUnfree = true;
    };
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
  sops = {
    defaultSopsFile = ./secrets/vault.yaml;
    defaultSopsFormat = "yaml";
    age = {
      generateKey = false;
      keyFile = "/Users/eden.zimbelman/Library/Application Support/sops/age/keys.txt";
      sshKeyPaths = [ ];
    };
    gnupg = {
      sshKeyPaths = [ ];
    };
    secrets = {
      "ai/anthropic" = {
        owner = input.config.users.users."eden.zimbelman".name;
      };
      "ai/huggingface" = {
        owner = input.config.users.users."eden.zimbelman".name;
      };
      "ai/openai" = {
        owner = input.config.users.users."eden.zimbelman".name;
      };
      "ai/vertex/location" = {
        owner = input.config.users.users."eden.zimbelman".name;
      };
      "ai/vertex/project" = {
        owner = input.config.users.users."eden.zimbelman".name;
      };
    };
  };
  system = {
    configurationRevision = self.rev or self.dirtyRev or null;
    stateVersion = 5;
  };
  users = {
    users = {
      "eden.zimbelman" = {
        home = /Users/eden.zimbelman;
        name = "eden.zimbelman";
      };
    };
  };
}
