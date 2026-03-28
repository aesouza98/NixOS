{ self, inputs, ... }:
{

  flake.nixosModules.gaming =
    { pkgs, ... }:
    {
      # Enable Programs
      programs.steam = {
        enable = true;
        gamescopeSession.enable = true;
      };

      programs.gamemode.enable = true;

      # Install Packages
      environment.systemPackages = with pkgs; [
        bottles
        discord
        hydralauncher
        protonup-ng
        wine
        wine64
        winetricks
      ];

      # Configure Env Vars
      environment.sessionVariables = {
        # Steam
        STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
      };

      # Remove File Limits
      systemd.user.extraConfig = ''
        DefaultLimitNOFILE=1048576
      '';
      security.pam.loginLimits = [
        {
          domain = "@users";
          type = "soft";
          item = "nofile";
          value = "1048576";
        }
        {
          domain = "@users";
          type = "hard";
          item = "nofile";
          value = "1048576";
        }
      ];
    };
}
