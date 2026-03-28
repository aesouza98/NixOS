{ self, inputs, ... }:
{

  flake.nixosModules.NyxPrograms =
    { config, pkgs, ... }:
    {
      imports = [
        self.nixosModules.evince
        self.nixosModules.fish
        self.nixosModules.localsend
        self.nixosModules.neovim
        self.nixosModules.ssh
        self.nixosModules.vscode
        self.nixosModules.zsh
      ];
    };
}
