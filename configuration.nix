{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # hostname
  networking.hostName = "nyx";

  # sudo
  security.sudo = {
    enable = true;
    extraRules = [{
      users = [ "nano" ];
      commands = [{
        command = "ALL";
        options = [ "NOPASSWD" ];
      }];
    }];
  };

  # networking
  networking.networkmanager.enable = true;

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
    extraGroups = [ "networkmanager" "wheel" "gamemode" ];
  };

  # firmware updates
  hardware.enableRedistributableFirmware = true;

  # unfree packages
  nixpkgs.config.allowUnfree = true;

  # packages
  environment.systemPackages = with pkgs; [

    # general
    bitwarden-desktop
    brave-origin
    kdePackages.kate
    localsend
    obsidian
    solaar
    spotify

    # gaming
    lutris
    mangohud
    protonplus
    protontricks
    winetricks
    wineWow64Packages.stagingFull

    # cli
    bat
    bitwarden-cli
    claude-code
    deja
    delta
    eza
    fd
    fuzzel
    fzf
    git
    gh
    helix
    nh
    pfetch
    stow
    vim
    wget
    zoxide
  ];

  # firefox.
  programs.firefox.enable = true;

  # steam
  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };

  # nix-ld
  programs.nix-ld.enable = true;

  # gaming
  programs.gamemode.enable = true;
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

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
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # version
  system.stateVersion = "26.05";

}
