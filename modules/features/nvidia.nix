{ self, inputs, ... }: {

	flake.nixosModules.nvidia = {pkgs, ... }: {
        # NVidia
        hardware.graphics = {
            enable = true;
            enable32Bit = true;
        };
        services.xserver.videoDrivers = [ "nvidia" ];
        hardware.nvidia = {
            modesetting.enable = true;
            powerManagement.enable = true;
            powerManagement.finegrained = false; # set to true for laptops
            open = true;
            nvidiaSettings = true;
        };
        environment.sessionVariables = {
            # Nvidia
            GBM_BACKEND = "nvidia-drm";
            LIBVA_DRIVER_NAME = "nvidia";
            __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        };
	};
}
