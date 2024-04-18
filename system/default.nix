let
  desktop = [
    ./programs
    ./services
    ./core
    ./hardware
    ./nix
  ];

  laptop = desktop;
in {
  inherit desktop laptop;
}
