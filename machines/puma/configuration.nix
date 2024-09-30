# https://github.com/LnL7/nix-darwin
{ self, ... }:
{
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
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
      ez = {
        home = /Users/ez;
        name = "ez";
      };
    };
  };
}
