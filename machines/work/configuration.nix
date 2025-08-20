# https://github.com/LnL7/nix-darwin
{
  lib,
  pkgs,
  self,
  ...
}@input:
{
  environment = {
    systemPackages = [
      pkgs.act # https://github.com/nektos/act
      pkgs.code-cursor # https://github.com/getcursor/cursor
      pkgs.google-cloud-sdk # https://github.com/GoogleCloudPlatform/cloud-sdk-docker
      pkgs.ngrok # https://github.com/ngrok/ngrok
      pkgs.pinact # https://github.com/suzuki-shunsuke/pinact
      pkgs.vscode # https://github.com/microsoft/vscode
      pkgs.zizmor # https://github.com/zizmorcore/zizmor
    ];
  };
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
    config = {
      allowUnfreePredicate =
        pkg:
        builtins.elem (lib.getName pkg) [
          "cursor"
          "ngrok"
          "vscode"
        ];
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
