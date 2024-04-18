_: {
  imports = [./hardware-configuration.nix];

  boot = {
    # load modules on boot 
    kernelModules = ["v4l2loopback"];
    kernelParams = ["nvidia.NVreg_PreserveVideoMemoryAllocations=1"];
  };
 
  networking.hostName = "anchor";
  services.fstrim.enable = true;
}
