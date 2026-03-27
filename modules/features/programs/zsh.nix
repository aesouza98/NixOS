{ self, inputs, ... }: {

	flake.nixosModules.zsh = { ... }: {
        programs.zsh = {
            enable = true;
            ohMyZsh.enable = true;
        };
    };
}
