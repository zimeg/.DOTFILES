{
  description = "@zimeg machinations";
  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
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
    nixosConfigurations = {
      tom = nixpkgs.lib.nixosSystem {
        modules = [
          nur.nixosModules.nur
          ./machines/tom/configuration.nix
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.default = {
              imports = [
                ./programs/home.nix
              ];
            };
            home-manager.sharedModules = [ nur.hmModules.nur ];
          }
        ];
      };
    };
  };
}
