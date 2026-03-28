{ self, inputs, ... }:
{

  flake.nixosModules.NyxDisks =
    { config, pkgs, ... }:
    {
      boot.supportedFilesystems = [ "ntfs" ];
      fileSystems."/home/nano/hdd" = {
        device = "/dev/disk/by-uuid/347CF2B57CF270CA";
        fsType = "ntfs-3g";
        options = [
          "defaults"
          "nofail"
          "x-systemd.device-timeout=1s"
        ];
      };

      fileSystems."/Windows" = {
        device = "/dev/disk/by-uuid/637626E62EC8A6A5";
        fsType = "ntfs-3g";
        options = [
          "defaults"
          "nofail"
          "x-systemd.device-timeout=1s"
        ];
      };
    };
}
