{
  description = "NixOS configuration";

  # This defines sources that flakes needs to fetch
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
    };
  };

  # This defines nix code that are evaluated after fetching the inputs
  outputs = {
    self,
    alejandra,
    nixpkgs,
    ...
  } @ inputs: {
    nixosConfigurations = {
      default = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        # These are chunks of nix code that extends the configuration
        modules = [
          {
            environment.systemPackages = [alejandra.defaultPackage.${system}];
          }
          ./hosts/default/configuration.nix
          inputs.home-manager.nixosModules.default
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.lonen = import ./hosts/default/home.nix;
            home-manager.extraSpecialArgs = {inherit inputs;};
          }
        ];
      };
    };
  };
}
