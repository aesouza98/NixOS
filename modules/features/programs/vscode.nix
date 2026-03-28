{ self, inputs, ... }: {

	flake.nixosModules.vscode = { pkgs, ... }: {
        programs.vscode = {
            enable = true;
            extentions = with pkgs.vscode-extensions; [
                bbenoist.nix
            ];
        };
    };
}
