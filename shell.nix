{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # base
    quickshell
    xwayland-satellite

    # qml modules
    kdePackages.qtdeclarative
    kdePackages.qt5compat
    kdePackages.qtmultimedia
    kdePackages.qtsvg
    kdePackages.qtimageformats
    kdePackages.qtwayland

    # system
    wl-clipboard
    cliphist
    brightnessctl
    ddcutil
    playerctl
    libnotify
    networkmanagerapplet
    pavucontrol
    polkit_gnome

    # wallpaper and lock
    swayidle
    hyprlock
    awww
    swaybg

    # screenshot
    grim
    slurp
    swappy
    gpu-screen-recorder

    # theme
    matugen
    adw-gtk3 nwg-look
    kdePackages.qt6ct
    cava

  ];

  # fonts
  fonts.packages = with pkgs; [
    material-symbols
    nerd-fonts.jetbrains-mono
    inter
  ];
}
