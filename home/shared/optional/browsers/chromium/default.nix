{config, ...}: {
  programs.chromium = lib.mkIf (!config.chrome.enable) {
    extensions = [
      # "" # BitWarden
      "kbfnbcaeplbcioakkpcpgfkobkghlhen" # Grammarly
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
      "mdjildafknihdffpkfmmpnpoiajfjnjd" # Consent-O-Matic
      "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock for YouTube
      "gebbhagfogifgggkldgodflihgfeippi" # Return YouTube Dislike
      "fdpohaocaechififmbbbbbknoalclacl" # GoFullPage
      "clpapnmmlmecieknddelobgikompchkk" # Disable Automatic Gain Control
    ];
  };
}
