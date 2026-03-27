{ ... }: {
  flake.nixosModules.packages = { lib, config, pkgs, ... }:
    let
      cfg = config.hostPackages;
    in
    {
      # Define the toggles for your package groups
      options.hostPackages = {
        hypr.enable = lib.mkEnableOption "Hyprland related packages";
        appearance.enable = lib.mkEnableOption "Appearance packages";
        gnome.enable = lib.mkEnableOption "GNOME packages";
        dev.enable = lib.mkEnableOption "Development packages";
        gaming.enable = lib.mkEnableOption "Gaming packages";
        system.enable = lib.mkEnableOption "System packages";
        cli.enable = lib.mkEnableOption "CLI utilities";
        neovim.enable = lib.mkEnableOption "Neovim dependencies";
        desktop.enable = lib.mkEnableOption "General desktop apps";
      };

      # Apply the packages to environment.systemPackages if enabled
      config = lib.mkMerge [
        (lib.mkIf cfg.hypr.enable {
          environment.systemPackages = with pkgs; [
            alacritty cliphist grim fuzzel hyprlock hyprshot
            libnotify mako pamixer playerctl swaybg swayosd waybar
            wiremix wl-clip-persist wl-clipboard xwayland-satellite
          ];
        })
        
        (lib.mkIf cfg.appearance.enable {
          environment.systemPackages = with pkgs; [
            adwaita-fonts adwaita-icon-theme vimix-cursors yaru-theme
          ];
        })
        
        (lib.mkIf cfg.gnome.enable {
          environment.systemPackages = with pkgs; [
            eog file-roller gnome-keyring gsettings-desktop-schemas
            nautilus sushi
          ];
        })
        
        (lib.mkIf cfg.dev.enable {
          environment.systemPackages = with pkgs; [
            cargo docker docker-compose docker-buildx gcc gnumake
            go git lazydocker libgcc luarocks nodejs_22 python313
            ruby rustc yarn
          ];
        })
        
        (lib.mkIf cfg.gaming.enable {
          environment.systemPackages = with pkgs; [
            bottles discord hydralauncher protonup-ng wine wine64 winetricks
          ];
        })
        
        (lib.mkIf cfg.system.enable {
          environment.systemPackages = with pkgs; [
            egl-wayland ffmpeg_6-full flatpak gammastep polkit_gnome
            sof-firmware xdg-user-dirs xdg-user-dirs-gtk
          ];
        })
        
        (lib.mkIf cfg.cli.enable {
          environment.systemPackages = with pkgs; [
            atuin bash-completion bat eza fastfetch fd fish fzf ghostty gum
            jq lazygit libvirt nh parted qemu ripgrep starship stow tree unrar
            unzip virt-manager wget yazi zoxide
          ];
        })
        
        (lib.mkIf cfg.neovim.enable {
          environment.systemPackages = with pkgs; [
            bash-language-server pyright lua-language-server
            yaml-language-server vscode-json-languageserver nil
            dockerfile-language-server sqls marksman stylua shfmt
            prettier sqlfluff nixfmt biome python313Packages.flake8
            shellcheck ruff yamllint tflint ansible-lint hadolint
            markdownlint-cli
          ];
        })
        
        (lib.mkIf cfg.desktop.enable {
          environment.systemPackages = with pkgs; [
            bitwarden-desktop brave firefox gearlever gnome-calculator
            localsend mpv obsidian pureref qbittorrent spotify syncthing
            vlc waydroid waydroid-helper
          ];
        })
      ];
    };
}
