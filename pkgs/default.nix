{
  systems = ["x86_64-linux"];

  perSystem = {pkgs, ...}: {
    packages = {
      # instant repl with automatic flake loading
      repl = pkgs.callPackage ./repl {};
      wl-orc = pkgs.callPackage ./wl-ocr {};

      # SanFrancisco fonts
      SF-Mono = pkgs.callPackage ./SF-Mono {inherit (pkgs) stdenv;};
      SF-Pro = pkgs.callPackage ./SF-Pro {inherit (pkgs) stdenv;};
    };
  };
}
