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
      edenzim-ltmbn8v.internal.salesforce.com = inputs.nix-darwin.lib.darwinSystem {
        specialArgs = {
          inherit inputs self;
        };
        modules = [
          ./machines/puma/configuration.nix
          inputs.home-manager.darwinModules.home-manager
          {
            nixpkgs.overlays = [ nur.overlays.default ];
            home-manager = {
              sharedModules = [ nur.modules.homeManager.default ];
              useGlobalPkgs = true;
              useUserPackages = false;
              users = {
                "eden.zimbelman" = {
                  imports = [ ./programs/home.nix ];
                };
              };
            };
          }
        ];
      };
      ezmbp24.local = inputs.nix-darwin.lib.darwinSystem {
        specialArgs = {
          inherit inputs self;
        };
        modules = [
          ./machines/puma/configuration.nix
          inputs.home-manager.darwinModules.home-manager
          {
            nixpkgs.overlays = [ nur.overlays.default ];
            home-manager = {
              sharedModules = [ nur.modules.homeManager.default ];
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
          nur.modules.nixos.default
          ./machines/tom/configuration.nix
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              sharedModules = [ nur.modules.homeManager.default ];
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
