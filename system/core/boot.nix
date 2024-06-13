{pkgs, ...}: {
  boot = {
    bootspec.enable = true;
    initrd = {
      systemd.enable = true;
      supportedFilesystems = ["ntfs"];
    };

    kernelParams = ["quiet" "systemd.show_status=auto" "rd.udev.log_level=3"];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };

    tmp.cleanOnBoot = true;
  };
}
