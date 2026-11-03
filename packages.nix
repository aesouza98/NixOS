{ pkgs, ... }:
{
  # unfree packages
  nixpkgs.config.allowUnfree = true;

  # packages
  environment.systemPackages = with pkgs; [

    # general
    bitwarden-desktop
    (brave-origin.override { commandLineArgs = "--password-store=kwallet6"; })
    ghostty
    kdePackages.kate
    localsend
    (obsidian.override { commandLineArgs = "--password-store=kwallet6"; })
    qbittorrent
    solaar
    spotify
    zed-editor

    # gaming
    bottles
    (discord.override { commandLineArgs = "--password-store=kwallet6"; })
    faugus-launcher
    lutris
    mangohud
    protonplus
    protontricks
    umu-launcher-unwrapped
    winetricks
    wineWow64Packages.stagingFull

    # cli
    bat
    bitwarden-cli
    claude-code
    ddcutil
    deja
    delta
    eza
    fd
    ffmpeg-full
    fuzzel
    fzf
    git
    gh
    helix
    herdr
    jq
    nh
    pfetch
    ripgrep
    spotiflac
    stow
    vim
    wget
    wlsunset
    yt-dlp
    zoxide

    # lsp
    nil
    nixd
  ];

  # appimage
  programs.appimage = {
    enable = true;
    binfmt = true;
    package = pkgs.appimage-run.override {
      extraPkgs = pkgs: [ pkgs.mpv-unwrapped ];
    };
  };

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

  # flatpak
  services.flatpak.enable = true;
  services.flatpak.packages = [
    "it.mijorus.gearlever"
  ];
}
