let
  desktop = [
    ./programs
    ./services
    ./core
    ./hardware
  ];

  laptop = desktop;
in {
  inherit desktop laptop;
}
