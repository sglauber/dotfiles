let
  desktop = [
    ./programs
    ./services
    ./core
  ];

  laptop = desktop;
in {
  inherit desktop laptop;
}
