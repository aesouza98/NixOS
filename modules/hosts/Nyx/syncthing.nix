{ self, inputs, ... }:
{

  flake.nixosModules.syncthing =
    { config, pkgs, ... }:
    {
      # Syncthing
      services.syncthing = {
        enable = true;
        user = "nano";
        group = "users";
        configDir = "/home/nano/.local/state/syncthing/";
        overrideDevices = true;
        overrideFolders = true;
        settings = {
          devices = {
            "iPhone" = {
              id = "B24AQ5V-QRYEQQW-MENRLKS-TPPB5DY-RKGEE6E-POVC4Z5-P7XZOJZ-45LTAQA";
            };
            "Macbook" = {
              id = "YZZQHV5-XF7T2DO-SLJ4TBD-6OH6VB3-AV5474O-U777BYZ-L3MWTMK-CHFLLQK";
            };
          };
          folders = {
            "NanoVault" = {
              id = "4kmqu-rcy4z";
              path = "~/Documents/Vaults/NanoVault";
              devices = [
                "iPhone"
                "Macbook"
              ];
            };
          };
        };
      };
    };
}
