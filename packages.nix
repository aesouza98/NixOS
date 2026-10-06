{ pkgs, ... }:
{
  # unfree packages
  nixpkgs.config.allowUnfree = true;

  # packages
  environment.systemPackages = with pkgs; [

    # general
    bitwarden-desktop
    brave-origin
    ghostty
    kdePackages.kate
    localsend
    obsidian
    solaar
    spotify
    zed-editor

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
