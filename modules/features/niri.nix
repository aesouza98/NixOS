{ self, inputs, ... }:
{

  flake.nixosModules.niri =
    { pkgs, lib, ... }:
    {
      programs.niri = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.niri;
      };
      nixpkgs.config.allowUnfree = true;
    };

  perSystem =
    {
      pkgs,
      lib,
      self',
      ...
    }:
    {
      packages.niri = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs;
        settings = {
          spawn-at-startup = [
            (lib.getExe self'.packages.noctalia)
          ];
          input.keyboard = {
            xkb = {
              layout = "us";
              variant = "intl";
            };
          };

          layout.gaps = 8;

          outputs = {
            DP-1 = {
              mode = "2560x1440@155.000";
              scale = 1;
            };
          };

          binds = {
            "Mod+Space".spawn-sh = "${lib.getExe self'.packages.noctalia} ipc call launcher toggle";
            "Mod+Escape".spawn-sh = "${lib.getExe self'.packages.noctalia} ipc call sessionMenu toggle";
            "Mod+Return".spawn-sh = lib.getExe pkgs.ghostty;
            "Mod+E".spawn-sh = "${lib.getExe pkgs.nautilus} --new-window";
            "Mod+W".close-window = null;
            "Mod+O".spawn-sh = "${lib.getExe pkgs.obsidian}";
            "Mod+B".spawn-sh = "${lib.getExe pkgs.brave}";
          };
        };
      };
    };
}
