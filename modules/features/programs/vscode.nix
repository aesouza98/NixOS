{ self, inputs, ... }:
{

  flake.nixosModules.vscode =
    { pkgs, ... }:
    {
      programs.vscode = {
        enable = true;
        extensions = with pkgs.vscode-extensions; [
          bbenoist.nix
        ];
      };
    };
}
