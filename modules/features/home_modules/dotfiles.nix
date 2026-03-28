{ ... }:
{
  flake.homeModules.dotfiles =
    { config, ... }:
      let
        dotfiles = "${config.home.homeDirectory}/.dotfiles";
        create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
        dotfilesRepo = "https://github.com/aesouza98/dotfiles.git";
        dot-config = {
          nvim = "nvim";
          lazynvim = "lazynvim";
          niri = "niri";
          hypr = "hypr";
          alacritty = "alacritty";
          btop = "btop";
          ghostty = "ghostty";
          mako = "mako";
          fish = "fish";
          fuzzel = "fuzzel";
          shell = "shell";
          scripts = "scripts";
          starship = "starship";
          swayosd = "swayosd";
          themes = "themes";
          waybar = "waybar";
          wofi = "wofi";
        };
        dot-local = {
          bin = "bin";
          fonts = "share/fonts";
          hidden = "share/applications/hidden";
        };
      in
    {
      home.activation = {
        cloneDotfiles = lib.hm.dag.entryAfter ["writeBoundary"] ''
          if [ ! -d "${dotfiles}" ]; then
            echo "Cloning dotfiles..."
            ${pkgs.git}/bin/git clone ${dotfilesRepo} "${dotfiles}"

            # Optional: Automatically switch to SSH for future pushes
            # since you mentioned you have your keys configured.
            cd "${dotfiles}" && ${pkgs.git}/bin/git remote set-url origin git@github.com:yourusername/dotfiles.git
          else
            echo "Dotfiles already exist at ${dotfiles}, skipping clone."
          fi
        '';
      };
      # ZSH
      home.file = {
        # ".zshrc".source = create_symlink "${dotfiles}/dot-zshrc";
        # ".zshenv".source = create_symlink "${dotfiles}/dot-zshenv";
        # ".zprofile".source = create_symlink "${dotfiles}/dot-zprofile";
      }
      //
        # Local
        (builtins.mapAttrs (name: subpath: {
          target = ".local/${subpath}";
          source = create_symlink "${dotfiles}/dot-local/${subpath}";
          recursive = true;
        }) dot-local);

      xdg.configFile =
        # Config
        builtins.mapAttrs (name: subpath: {
          source = create_symlink "${dotfiles}/dot-config/${subpath}";
          recursive = true;
        }) dot-config;
      };
}
