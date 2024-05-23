{ config, lib, pkgs, ... }: {
    services = {
      samba = {
        package = pkgs.samba4Full;
        enable = true;
        openFirewall = true;
        shares.testshare = {
         # !TODO: get the current user
          path = "/home/glwbr/";
          writable = "true";
          comment = "This is a test!";
        };
        extraConfig = ''
          server smb encrypt = required
          # ^^ Note: Breaks `smbclient -L <ip/host> -U%` by default, might require the client to set `client min protocol`?
          server min protocol = SMB3_00
        '';
      };
      avahi = {
        publish.enable = true;
        publish.userServices = true;
        # ^^ Needed to allow samba to automatically register mDNS records (without the need for an `extraServiceFile`
        #nssmdns4 = true;
        enable = true;
        openFirewall = true;
      };
      samba-wsdd = {
        # This enables autodiscovery on windows since SMB1 (and thus netbios) support was discontinued
        enable = true;
        openFirewall = true;
      };
    };
}
