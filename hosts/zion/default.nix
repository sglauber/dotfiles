{inputs, ...}: {
  imports = [
    ./hardware.nix
    ./disko.nix
    ./powersave.nix
    ../shared/core/sops
    inputs.disko.nixosModules.disko
  ];

  boot = {
    # load modules on boot
    kernelModules = ["v4l2loopback"];
    kernelParams = ["nvidia.NVreg_PreserveVideoMemoryAllocations=1"];
  };

  networking.hostName = "zion";
  services.fstrim.enable = true;
}
