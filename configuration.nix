{ lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
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

  # hosts - toggle: hosts-toggle
  environment.etc.hosts.mode = "0644";
  system.activationScripts.hostsBlocklist = {
    deps = [ "etc" ];
    text = ''
      if [ -f /etc/hosts-blocklist ]; then
        cat /etc/hosts-blocklist >> /etc/hosts
      fi
    '';
  };
  specialisation.hosts-unfiltered.configuration = {
    system.activationScripts.hostsBlocklist = lib.mkForce "";
  };
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "hosts-toggle" ''
      set -euo pipefail
      base=/nix/var/nix/profiles/system
      unfiltered="$base/specialisation/hosts-unfiltered"
      if [ "$(readlink -f /run/current-system)" = "$(readlink -f "$unfiltered")" ]; then
        sudo "$base/bin/switch-to-configuration" switch
        echo "hosts: filtered"
      else
        sudo "$unfiltered/bin/switch-to-configuration" switch
        echo "hosts: unfiltered"
      fi
    '')
  ];

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

  # bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

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
    extraGroups = [
      "networkmanager"
      "wheel"
      "gamemode"
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
