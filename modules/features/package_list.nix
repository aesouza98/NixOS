{ ... }:
{
  flake.nixosModules.packages =
    {
      lib,
      config,
      pkgs,
      ...
    }:
    let
      cfg = config.hostPackages;
    in
    {
      # Define the toggles for your package groups
      options.hostPackages = {
        hypr.enable = lib.mkEnableOption "Hyprland related packages";
        appearance.enable = lib.mkEnableOption "Appearance packages";
        gnome.enable = lib.mkEnableOption "GNOME packages";
        dev_dependencies.enable = lib.mkEnableOption "General Dependencies";
        system.enable = lib.mkEnableOption "System packages";
        cli.enable = lib.mkEnableOption "CLI utilities";
        dev.enable = lib.mkEnableOption "IDEs, LSPs, Linters and Formatters";
        desktop.enable = lib.mkEnableOption "General desktop apps";
      };

      # Apply the packages to environment.systemPackages if enabled
      config = lib.mkMerge [
        (lib.mkIf cfg.hypr.enable {
          environment.systemPackages = with pkgs; [
            alacritty
            cliphist
            grim
            fcitx5
            fuzzel
            hyprlock
            hyprshot
            libnotify
            pamixer
            playerctl
            swaybg
            swayosd
            waybar
            wiremix
            wl-clip-persist
            wl-clipboard
            xwayland-satellite
          ];
        })

        (lib.mkIf cfg.appearance.enable {
          environment.systemPackages = with pkgs; [
            adwaita-fonts
            adwaita-icon-theme
            vimix-cursors
            yaru-theme
          ];
        })

        (lib.mkIf cfg.gnome.enable {
          environment.systemPackages = with pkgs; [
            eog
            file-roller
            gnome-keyring
            gsettings-desktop-schemas
            nautilus
            sushi
          ];
        })

        (lib.mkIf cfg.dev_dependencies.enable {
          environment.systemPackages = with pkgs; [
            cargo
            docker
            docker-compose
            docker-buildx
            gcc
            gnumake
            go
            git
            lazydocker
            libgcc
            luarocks
            nodejs_22
            python313
            python313Packages.pip
            python313Packages.spotipy
            python313Packages.yt-dlp
            ruby
            rustc
            yarn
          ];
        })

        (lib.mkIf cfg.system.enable {
          environment.systemPackages = with pkgs; [
            egl-wayland
            ffmpeg_6-full
            flatpak
            gammastep
            polkit_gnome
            sof-firmware
            xdg-user-dirs
            xdg-user-dirs-gtk
          ];
        })

        (lib.mkIf cfg.cli.enable {
          environment.systemPackages = with pkgs; [
            atuin
            bash-completion
            bat
            eza
            fastfetch
            fd
            fish
            fzf
            ghostty
            gum
            jq
            lazygit
            libvirt
            nh
            parted
            qemu
            ripgrep
            starship
            stow
            tree
            unrar
            unzip
            virt-manager
            wget
            yazi
            zoxide
            zellij
          ];
        })

        (lib.mkIf cfg.dev.enable {
          environment.systemPackages = with pkgs; [
            bash-language-server
            pyright
            lua-language-server
            yaml-language-server
            vscode-json-languageserver
            nil
            dockerfile-language-server
            sqls
            marksman
            stylua
            shfmt
            prettier
            sqlfluff
            nixfmt
            biome
            python313Packages.flake8
            shellcheck
            ruff
            yamllint
            tflint
            ansible-lint
            hadolint
            markdownlint-cli
            zed-editor
            nixd
            helix
            awk-language-server
            vscode-css-languageserver
            docker-compose-language-service
            terraform-lsp
            jq-lsp
            ty
            systemd-language-server
            ansible-language-server
          ];
        })

        (lib.mkIf cfg.desktop.enable {
          environment.systemPackages = with pkgs; [
            bitwarden-desktop
            brave
            firefox
            gearlever
            gnome-calculator
            localsend
            mpv
            obsidian
            pureref
            qbittorrent
            spotify
            syncthing
            vlc
            waydroid
            waydroid-helper
          ];
        })
      ];
    };
}
