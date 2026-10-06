{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nyx"; # Define your hostname.

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

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
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

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # nvidia
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    open = true;
    branch = "stable";
    modesetting.enable = true;
  };

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "mac";
    options = "lv3:menu_switch";
  };

  # Enable CUPS to print documents.
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

  # programs

  # firefox.
  programs.firefox.enable = true;

  # steam
  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };

  # nix-ld
  programs.nix-ld.enable = true;

  # fix steam cursor
  systemd.tmpfiles.rules = [
    "L+ /home/nano/.local/share/icons/breeze_cursors - - - - ${pkgs.kdePackages.breeze}/share/icons/breeze_cursors"
  ];

  # gaming
  programs.gamemode.enable = true;
  programs.gamescope = {
    enable = true;
    capSysNice = true;
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
    eza
    fd
    fuzzel
    fzf
    git
    gh
    helix
    pfetch
    stow
    vim
    wget
    zoxide
  ];

  # programs

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
