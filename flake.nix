{
    description = "Lonen's Floquinhos";
	inputs = {
		# Core
		nixpkgs = {
		    url = "github:nixos/nixpkgs/nixos-unstable";
		};

		home-manager = {
			url = "github:nix-community/home-manager/master";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		hyprland = {
			url = "github:hyprwm/hyprland";
		};

		waybar-hyprland = { 
			url = "github:hyprwm/hyprland";
		};

		xdg-portal-hyprland = {
			url = "github:hyprwm/xdg-desktop-portal-hyprland";
		};
		
		nur = {
			url = "github:nix-community/NUR";
		};
		
		nix-colors = {
			url = "github:misterio77/nix-colors";
		};

		spicetify-nix = {
			url = "github:the-argus/spicetify-nix";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		disko = {
			url = "github:nix-community/disko";
		};
		
		neovim-nightly-overlay = {
			url = "github:nix-community/neovim-nightly-overlay";
		};
		
		nix-ld-rs = {
			url = "github:nix-community/nix-ld-rs";
		};

		# SFMono w/ patches
		sf-mono-liga-src = {
			url = "github:shaunsingh/SFMono-Nerd-Font-Ligaturized";
			flake = false;
		};
  };

  outputs = {
    self,
    nixpkgs,
    hyprland,
    home-manager,
    spicetify-nix,
    disko,
    ...
  } @ inputs: let
    supportedSystems = ["x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin"];

    # Helper function to generate an attrset '{ x86_64-linux = f "x86_64-linux"; ... }'.
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

    # Nixpkgs instantiated for supported system types.
    nixpkgsFor = forAllSystems (system: import nixpkgs {inherit system;});
  in {
  	nixosConfigurations = {
		anchor = nixpkgs.lib.nixosSystem {
		system = "x86_64-linux";
		specialArgs = { inherit inputs hyprland spicetify-nix disko; };
          	modules = [
		    ./hosts/anchor/configuration.nix
		    home-manager.nixosModules.home-manager 
		    {
		        home-manager = {
			    useUserPackages = true;
			    useGlobalPkgs = false;
			    extraSpecialArgs = { inherit inputs spicetify-nix disko; };
			    users.lonen = ./home/desktop/home.nix;
			};
            	    }
		    hyprland.nixosModules.default
		    { programs.hyprland.enable = true; }
		    disko.nixosModules.disko
          	];
        };
    };
    devShells = forAllSystems (system: let
      pkgs = nixpkgsFor.${system};
    in {
      default = pkgs.mkShell {
        buildInputs = with pkgs; [
          git
          alejandra
          statix
        ];
      };
    });
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
  };
}
