{ self, inputs, ... }:
{
  flake.nixosModules.NyxConfig =
    { config, pkgs, ... }:

    {
      imports = [
        # Host Specifics
        self.nixosModules.NyxHardware
        self.nixosModules.NyxPkgs
        self.nixosModules.NyxHome
        self.nixosModules.NyxDisks
        self.nixosModules.NyxPrograms
        self.nixosModules.syncthing

        # Modules
        self.nixosModules.beancount
        self.nixosModules.gaming # Enable Gaming
        self.nixosModules.gc # Enable Garbage Collection
        self.nixosModules.ldd # Enable LDD libraries
        self.nixosModules.nvidia # Install and configure Nvidia Drivers
        self.nixosModules.niri # Install and configure the Niri Window Manager (With Noctalia shell)
        self.nixosModules.sudo # Configure Sudo
      ];

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      networking.hostName = "Nyx";

      # Enable networking
      networking.networkmanager.enable = true;

      time.timeZone = "America/Sao_Paulo";

      # Select internationalisation properties.
      i18n.defaultLocale = "en_US.UTF-8";

      i18n.extraLocaleSettings = {
        LC_ADDRESS = "pt_BR.UTF-8";
        LC_CTYPE = "pt_BR.UTF-8";
        LC_IDENTIFICATION = "pt_BR.UTF-8";
        LC_MEASUREMENT = "pt_BR.UTF-8";
        LC_MONETARY = "pt_BR.UTF-8";
        LC_NAME = "pt_BR.UTF-8";
        LC_NUMERIC = "pt_BR.UTF-8";
        LC_PAPER = "pt_BR.UTF-8";
        LC_TELEPHONE = "pt_BR.UTF-8";
        LC_TIME = "pt_BR.UTF-8";
      };

      # Enable the X11 windowing system.
      services.xserver.enable = true;

      # Enable the GNOME Desktop Environment.
      services.xserver.displayManager.gdm.enable = true;
      services.xserver.desktopManager.gnome.enable = true;

      # Configure keymap in X11
      services.xserver.xkb = {
        layout = "us";
        variant = "intl";
      };

      # Configure console keymap
      console.keyMap = "us-acentos";

      # Enable sound with pipewire.
      services.pulseaudio.enable = false;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };

      # Define a user account. Don't forget to set a password with ‘passwd’.
      users.users.nano = {
        isNormalUser = true;
        description = "nano";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
        shell = pkgs.zsh;
      };
      programs.git = {
        enable = true;
        config = {
          user.name = "Adriano Elias";
          user.email = "github@nano.slmail.me";
          init.defaultBranch = "master";
        };
      };

      system.stateVersion = "25.11";

    };
}
