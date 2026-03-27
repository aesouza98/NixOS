{ ... }: {
  flake.homeModules.gnome-settings = { ... }: {
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        icon-theme = "Yaru-blue";
      };
    };
    home.sessionVariables = {
       GTK_DEFAULT_COLOR_SCHEME = "prefer-dark";
    };
  };
}
