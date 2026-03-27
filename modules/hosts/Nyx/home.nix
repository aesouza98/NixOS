{ self, inputs, ... }: {
  flake.nixosModules.NyxHome = { config, pkgs, ... }: {
    
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];

    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    
    home-manager.extraSpecialArgs = { inherit inputs self; };

    # Configure user
    home-manager.users.nano = {
      imports = [
      	self.homeModules.gnome-settings
      	self.homeModules.git
      ];

      home.username = "nano";
      home.homeDirectory = "/home/nano";
      home.stateVersion = "25.11"; 

      # Let home-manager install and manage itself
      programs.home-manager.enable = true;
    };
  };
}
