# {
#   lib,
#   config,
#   ...
# }: let
#   mkFontOption = kind: {
#     family = lib.mkOption {
#       type = lib.types.str;
#       default = null;
#       description = "Family name for ${kind} font profile";
#       example = "Fira Code";
#     };
#     package = lib.mkOption {
#       type = lib.types.package;
#       default = null;
#       description = "Package for ${kind} font profile";
#       example = "pkgs.fira-code";
#     };
#   };
#   cfg = config.fontProfiles;
# in {
#   options.fontProfiles = {
#     enable = lib.mkEnableOption "Whether to enable font profiles";
#     monospace = mkFontOption "monospace";
#     regular = mkFontOption "regular";
#   };
#
#   config = lib.mkIf cfg.enable {
#     fonts.fontconfig.enable = true;
#     home.packages = [
#       cfg.monospace.package
#       cfg.regular.package
#     ];
#   };
# }
{
  pkgs,
  inputs,
  ...
}: {
  fonts = {
    packages = with pkgs; [
      # Sans(Serif) fonts
      noto-fonts
      roboto
      (google-fonts.override {fonts = ["Inter"];})

      # Monospace fonts
      # maple-mono-SC-NF
      # inputs.aesthetic-iosevka.packages.${pkgs.system}.default
      # inputs.self.packages.${pkgs.system}.SF-Mono
      # inputs.self.packages.${pkgs.system}.SF-Pro

      # nerdfonts
      (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly" "JetBrainsMono" "UbuntuMono"];})
    ];
  };
}
