_: {
  boot = {
    initrd = {
      systemd.enable = true;
      supportedFilesystems = ["ntfs"];
    };

    loader = {
      grub.enable = false;

      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
      timeout = 3;
    };

    tmp.cleanOnBoot = true;
  };
}
