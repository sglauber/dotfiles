{lib, ...}: {
    networking = {
        networkmanager = {
            enable = true;
            wifi.powersave = true;
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

        # DNS resolver
        resolved.enable = true;
    };

    # Don't wait for network startup
    systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
}
