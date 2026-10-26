{ pkgs, ... }:
{
  # unfree packages
  nixpkgs.config.allowUnfree = true;

  # packages
  environment.systemPackages = with pkgs; [

    # general
    bitwarden-desktop
    brave-origin
    gearlever
    ghostty
    kdePackages.kate
    localsend
    obsidian
    qbittorrent
    solaar
    spotify
    zed-editor

    # gaming
    bottles
    discord
    faugus-launcher
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
    ripgrep
    stow
    vim
    wget
    zoxide

    # lsp
    nil
    nixd
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
}
