{
  description = "@zimeg machinations";
  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    nur = {
      url = "github:nix-community/NUR";
    };
  };
  outputs = { self, nixpkgs, nur, ... }@inputs: {
    darwinConfigurations = {
      ezmbp24.local = inputs.nix-darwin.lib.darwinSystem {
        specialArgs = {
          inherit inputs self;
        };
        modules = [
          ./machines/puma/configuration.nix
          inputs.home-manager.darwinModules.home-manager
          {
            home-manager = {
              sharedModules = [ nur.hmModules.nur ];
              useGlobalPkgs = true;
              useUserPackages = false;
              users = {
                "ez" = {
                  imports = [ ./programs/home.nix ];
                };
              };
            };
          }
        ];
      };
    };
    nixosConfigurations = {
      tom = nixpkgs.lib.nixosSystem {
        modules = [
          ./machines/tom/configuration.nix
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              sharedModules = [ nur.hmModules.nur ];
              useGlobalPkgs = true;
              useUserPackages = true;
              users = {
                default = {
                  imports = [ ./programs/home.nix ];
                };
              };
            };
          }
        ];
      };
    };
  };
}
