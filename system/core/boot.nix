{pkgs, config, ...}: {
    boot = {
        # plymouth.enable = true;
        # tmp.cleanOnBoot = true;

        kernelModules = ["v4l2loopback"];
        kernelParams = ["nvidia.NVreg_PreserveVideoMemoryAllocations=1"];
        loader = { 
		    efi.canTouchEfiVariables = true;
    	    efi.efiSysMountPoint = "/boot";
	        systemd-boot.enable = true;
		    timeout = 10;
        };
	    supportedFilesystems = ["ntfs"];
    };

    hardware = {
        nvidia = {
            open = false;
            nvidiaSettings = true;
            powerManagement.enable = true;
            modesetting.enable = true;
            package = config.boot.kernelPackages.nvidiaPackages.stable;
        };

        opengl = {
            enable = true;
            driSupport32Bit = true;
            extraPackages = with pkgs; [nvidia-vaapi-driver];
        };
    };
}
