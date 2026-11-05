{ lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ./niri.nix
    ./shell.nix
  ];

  # bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # hostname
  networking.hostName = "nyx";

  # sudo
  security.sudo = {
    enable = true;
    extraRules = [
      {
        users = [ "nano" ];
        commands = [
          {
            command = "ALL";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
  };

  # envs
  environment.sessionVariables = {
    NH_FLAKE = "$HOME/.nix/";
    GTK_IM_MODULE = "gtk-im-context-simple";
  };

  # automount
  fileSystems."/mnt/ssd" = {
    device = "/dev/disk/by-uuid/1c21689f-e9d6-4d07-9fc0-bdc5a3a01eeb";
    fsType = "ext4";
    options = [
      "defaults"
      "nofail"
    ];
  };
  fileSystems."/mnt/hdd" = {
    device = "/dev/disk/by-uuid/fc74f4f4-9fb3-4d18-b8a1-5732f92a2a9d";
    fsType = "ext4";
    options = [
      "defaults"
      "nofail"
    ];
  };

  # symlinks
  systemd.tmpfiles.rules = [
    "L+ /home/nano/Documents - - - - /mnt/ssd/Files"
    "L+ /home/nano/Pictures - - - - /mnt/ssd/Imagens"
  ];

  # networking
  networking.networkmanager.enable = true;
  networking.interfaces.enp3s0.wakeOnLan.enable = true;

  # timezone
  time.timeZone = "America/Sao_Paulo";

  # locales
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # monitor
  hardware.i2c.enable = true;

  # bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;


  # x11
  services.xserver.enable = true;

  # nvidia
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    open = true;
    branch = "stable";
    modesetting.enable = true;
  };

  # kde plasma
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # keyboard
  services.xserver.xkb = {
    layout = "us";
    variant = "mac";
    options = "lv3:menu_switch";
  };

  # CUPS
  services.printing.enable = false;

  # pipewire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # user
  users.users."nano" = {
    isNormalUser = true;
    description = "Adriano Elias";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "gamemode"
      "i2c"
    ];
  };

  # firmware updates
  hardware.enableRedistributableFirmware = true;

  # zsh
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
    enableLsColors = true;
  };

  # mtr
  programs.mtr.enable = true;

  # gpg/ssh
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # ssh
  services.openssh.enable = true;

  # remote desktop
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
    settings = {
      capture = "kms";
      csrf_allowed_origins = "https://nyx.local:47990,https://192.168.100.9:47990";
    };
  };

  # mdns
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };

  # firewall
  networking.firewall.enable = false;

  # flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # version
  system.stateVersion = "26.05";

}
