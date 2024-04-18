{config, ...}: {
  # graphics drivers / HW accel
  hardware.nvidia = {
    open = false;
    nvidiaSettings = true;
    powerManagement.enable = true;
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
