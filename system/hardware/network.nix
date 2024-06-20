{config, ...}: {
  sops.secrets.wireless = {
    sopsFile = ../../hosts/shared/secrets.yaml;
    neededForUsers = true;
  };

  networking.wireless = {
    enable = true;
    fallbackToWPA2 = false;
    environmentFile = config.sops.secrets.wireless.path;
    networks = {
      "UAIFAI" = {
        pskRaw = "@UAIFAI@";
      };

      "UAIFAI_5G" = {
        pskRaw = "@UAIFAI5G@";
      };
    };

    # Imperative
    allowAuxiliaryImperativeNetworks = true;
    userControlled = {
      enable = true;
      group = "network";
    };

    extraConfig = ''
      update_config=1
    '';
  };

  services = {
    openssh = {
      enable = true;
      settings.UseDns = true;
    };
  };

  # Ensure group exists
  users.groups.network = {};

  systemd.services.wpa_supplicant.preStart = "touch /etc/wpa_supplicant.conf";
}
