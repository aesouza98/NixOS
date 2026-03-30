{ self, inputs, ... }:
{

  flake.nixosModules.niri =
    { pkgs, ... }:
    {
      programs.niri = {
        enable = true;
        useNautilus = true;
      };
      environment.systemPackages = [
        pkgs.noctalia-shell
      ];
    };
}
