_: {
    imports = [./hardware-configuration.nix];

    networking = {
        networkmanager.enable = true;
        enableIPv6 = false;
        dhcpcd.wait = "background";
        dhcpcd.extraConfig = "noarp";
        hostName = "anchor";
    };

    services = {
        fstrim.enable = true;
    };
}
