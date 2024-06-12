{pkgs, ...}: {
  fonts.packages = with pkgs; [
    noto-fonts
    roboto
    (google-fonts.override {fonts = ["Inter"];})
    (nerdfonts.override {
      fonts = [
        "DejaVuSansMono"
        "JetBrainsMono"
        "UbuntuMono"
      ];
    })
  ];
}
