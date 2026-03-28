{ self, inputs, ... }: {

	flake.nixosModules.vscode = { ... }: {
        programs.vscode = {
            enable = true;
            extentions = with pkgs.vscode-extensions; [
                bbenoist.nix
            ]
        };
    };
}
