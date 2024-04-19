{lib, ...}: {
  networking = {
    networkmanager = {
      enable = true;
      wifi.powersave = false;
    };

    enableIPv6 = false;
    dhcpcd.wait = "background";
    dhcpcd.extraConfig = "noarp";
  };

  services = {
    openssh = {
      enable = true;
      settings.UseDns = true;
    };
  };
}
