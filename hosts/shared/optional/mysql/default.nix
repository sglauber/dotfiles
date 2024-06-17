{pkgs, ...}: {
  services.mysql = {
    enable = true;
    package = with pkgs; [mariadb];
  };
}
