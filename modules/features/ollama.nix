{ self, inputs, ... }:
{

  flake.nixosModules.ollama =
    { pkgs, ... }:
    {
      nix.settings = {
        substituters = [
          "https://cuda-maintainers.cachix.org"
        ];
        trusted-public-keys = [
          "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
        ];
      };

      hardware.graphics.enable = true;
      services.xserver.videoDrivers = [ "nvidia" ];

      services.ollama = {
        enable = true;
        package = pkgs.ollama-cuda;
      };

      environment.systemPackages = with pkgs; [
        ollama
        # claude-code
        # aider-chat # melhor CLI para codificação (lê seus arquivos locais)
        oterm # cliente de chat bonito direto no terminal (opcional)
        litellm
      ];

      users.users.nano = {
        extraGroups = [
          "networkmanager"
          "wheel"
          "video"
          "render"
        ];
      };

      virtualisation.docker.enable = true;
    };
}
