{inputs, ...}: {
  imports = [inputs.disko.nixosModules.disko];

  disko.devices.disk.mmc = {
    type = "disk";
    device = "/dev/disk/by-id/{replace}";
    content = {
      type = "gpt";
      partitions = {
        ESP = {
          type = "EF00";
          size = "500M";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
          };
        };
        swap = {
          size = "16G";
          content = {
            type = "swap";
            resumeDevice = true; # resume from hiberation from this device
          };
        };
        root = {
          size = "100%";
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/";
          };
        };
      };
    };
  };
}
