# https://github.com/LnL7/nix-darwin
{ self, ... }:
{
  nix = {
    settings = {
      allowed-impure-host-deps = [
        "/usr/bin/ditto" # https://github.com/zimeg/.DOTFILES/issues/21
      ];
      experimental-features = [ "nix-command" "flakes" ];
      sandbox = true;
    };
  };
  nixpkgs = {
    hostPlatform = "aarch64-darwin";
  };
  services = {
    nix-daemon = {
      enable = true;
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
      ez = {
        home = /Users/ez;
        name = "ez";
      };
    };
  };
}
