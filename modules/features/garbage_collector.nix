 { self, inputs, ... }: {

	flake.nixosModules.gc = { pkgs, lib, ... }: {
        nix.gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 7d";
    };	
  };
}

  