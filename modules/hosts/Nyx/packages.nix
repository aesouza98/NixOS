{ self, ... }: {
  flake.nixosModules.NyxPkgs = { ... }: {
    imports = [
    	self.nixosModules.packages
    ];

    hostPackages = {
      desktop.enable = true;
      appearance.enable = true;
      gaming.enable = true;
      gnome.enable = true;
      dev_dependencies.enable = true;
      hypr.enable = true;
      cli.enable = true;
      dev.enable = true;
      system.enable = true;
    };

    nixpkgs.config.allowUnfree = true;
  };
}
