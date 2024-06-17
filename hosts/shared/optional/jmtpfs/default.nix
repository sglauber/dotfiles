{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    jmtpfs
  ];
}
