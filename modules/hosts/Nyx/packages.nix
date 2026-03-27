{ self, ... }: {
  flake.nixosModules.NyxPkgs = { ... }: {
    imports = [
    	self.nixosModules.packages
	self.nixosModules.localsend
    ];

    hostPackages = {
      desktop.enable = true;
      appearance.enable = true;
      gaming.enable = true;
      gnome.enable = true;
      neovim.enable = true;
      hypr.enable = true;
      cli.enable = true;
      dev.enable = true;
      system.enable = true;
    };

    nixpkgs.config.allowUnfree = true;
  };
}
