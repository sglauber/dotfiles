{pkgs, ...}: {
  # graphics drivers / HW accel
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [nvidia-vaapi-driver];
  };
}
