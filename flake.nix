{
  description = "Lonen's Floquinhos";

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];

      imports = [
        ./home
        ./hosts
        ./lib
        ./modules
        ./pkgs
        ./pre-commit-hooks.nix
      ];

      perSystem = {
        config,
        pkgs,
        ...
      }: {
        devShells = {
          default = pkgs.mkShell {
            packages = [
              pkgs.alejandra
              pkgs.git
              config.packages.repl
            ];
            name = "dots";
            DIRENV_LOG_FORMAT = "";
            shellHook = ''
              ${config.pre-commit.installationScript}
            '';
          };
        };

        formatter = pkgs.alejandra;
      };
    };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    aesthetic-iosevka.url = "github:alphatechnolog/aesthetic-iosevka";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fu.url = "github:numtide/flake-utils";

    hm = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprfocus = {
      url = "github:pyt0xic/hyprfocus";
      inputs.hyprland.follows = "hyprland";
    };

    hypridle.url = "github:hyprwm/hypridle";

    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    };

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprlock.url = "github:hyprwm/hyprlock";

    hyprpaper.url = "github:hyprwm/hyprpaper";

    matugen = {
      url = "github:InioX/matugen";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-db = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "fu";
    };

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:MichaelPachec0/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sss = {
      url = "github:SergioRibera/sss/";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    xdg-portal-hyprland.url = "github:hyprwm/xdg-desktop-portal-hyprland";

    yazi.url = "github:sxyazi/yazi";
  };
}
