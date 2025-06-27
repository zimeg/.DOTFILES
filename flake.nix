{
  description = "@zimeg machinations";
  inputs = {
    git-coverage = {
      url = "github:zimeg/git-coverage";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence = {
      url = "github:nix-community/impermanence";
    };
    newsflash-nvim = {
      url = "github:zimeg/newsflash.nvim";
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
      inputs.nixpkgs.follows = "nixpkgs";
    };
    proximity-nvim = {
      url = "github:zimeg/proximity.nvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      nur,
      ...
    }@inputs:
    {
      darwinConfigurations = {
        edenzim-ltmbn8v.internal.salesforce.com = inputs.nix-darwin.lib.darwinSystem {
          specialArgs = {
            inherit inputs self;
          };
          modules = [
            ./machines/work/configuration.nix
            inputs.home-manager.darwinModules.home-manager
            inputs.sops-nix.darwinModules.sops
            {
              nixpkgs.overlays = [ nur.overlays.default ];
              home-manager = {
                extraSpecialArgs = {
                  inherit inputs;
                };
                sharedModules = [ nur.modules.homeManager.default ];
                useGlobalPkgs = false; # https://github.com/zimeg/.DOTFILES/issues/29
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
            inputs.sops-nix.darwinModules.sops
            {
              nixpkgs.overlays = [ nur.overlays.default ];
              home-manager = {
                extraSpecialArgs = {
                  inherit inputs;
                };
                sharedModules = [ nur.modules.homeManager.default ];
                useGlobalPkgs = false; # https://github.com/zimeg/.DOTFILES/issues/29
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
            inputs.impermanence.nixosModules.impermanence
            inputs.sops-nix.nixosModules.sops
            {
              home-manager = {
                extraSpecialArgs = {
                  inherit inputs;
                };
                sharedModules = [ nur.modules.homeManager.default ];
                useGlobalPkgs = false; # https://github.com/zimeg/.DOTFILES/issues/29
                useUserPackages = true;
                users = {
                  default = {
                    imports = [
                      ./machines/tom/home.nix
                      ./programs/home.nix
                    ];
                  };
                };
              };
            }
          ];
        };
      };
    };
}
