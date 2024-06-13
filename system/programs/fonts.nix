{
  pkgs,
  inputs,
  ...
}: {
  fonts = {
    packages = with pkgs; [
      # icon fonts
      material-symbols

      # Sans(Serif) fonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      roboto
      (google-fonts.override {fonts = ["Inter"];})

      # Monospace fonts
      maple-mono-SC-NF
      inputs.aesthetic-iosevka.packages.${pkgs.system}.default
      inputs.self.packages.${pkgs.system}.SF-Mono
      inputs.self.packages.${pkgs.system}.SF-Pro

      # nerdfonts
      (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly" "JetBrainsMono" "DejaVuSansMono"];})
    ];

    # causes more issues than it solves
    enableDefaultPackages = false;

    # user defined fonts
    # the reason there's Noto Color Emoji everywhere is to override DejaVu's
    # B&W emojis that would sometimes show instead of some Color emojis
    fontconfig = {
      enable = true;
      antialias = true;
      hinting = {
        enable = true;
        autohint = false;
        style = "full";
      };

      subpixel = {
        lcdfilter = "default";
        rgba = "rgb";
      };

      defaultFonts = {
        serif = ["SF Pro Text" "Noto Color Emoji"];
        sansSerif = ["SF Pro Display" "Noto Color Emoji"];
        monospace = ["LigaSFMono Nerd Font" "Noto Color Emoji"];
        emoji = ["Noto Color Emoji"];
      };
    };

    fontDir = {
      enable = true;
      decompressFonts = true;
    };
  };
}
