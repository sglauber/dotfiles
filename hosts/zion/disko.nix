{inputs, ...}: {
  imports = [inputs.disko.nixosModules.disko];

  disko.devices.disk.ssd = {
    type = "disk";
    device = "/dev/disk/by-id/ata-P3-256_0013893023569";
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
            resumeDevice = true;
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
