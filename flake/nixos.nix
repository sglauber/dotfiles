{inputs, ...}: {
  flake.nixosConfigurations = let
    mkHost = {
      hostname,
      username,
      stateVersion ? "24.05",
    }:
      inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ../hosts/${hostname}
          inputs.disko.nixosModules.disko
          inputs.hm.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${username}.imports = [../home];
              extraSpecialArgs = {
                inherit inputs hostname username stateVersion;
              };
            };
          }
        ];
      };
  in {
    zion = mkHost {
      hostname = "zion";
      username = "glwbr";
    };

    bethel = mkHost {
      hostname = "bethel";
      username = "glwbr";
    };
  };
}
