# https://github.com/LnL7/nix-darwin
{ pkgs, self, ... }:
{
  imports = [
    ../../programs/darwin
    ./programs/darwin
    ./services/github-runners
  ];
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
