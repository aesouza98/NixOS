{ self, inputs, ... }:
{

  flake.nixosModules.ollama =
    { pkgs, ... }:
    {

      hardware.graphics.enable = true;
      services.xserver.videoDrivers = [ "nvidia" ];

      services.ollama = {
        enable = true;
        acceleration = "cuda"; # força o uso da gpu
      };

      environment.systemPackages = with pkgs; [
        ollama
        aider-chat # melhor CLI para codificação (lê seus arquivos locais)
        oterm # cliente de chat bonito direto no terminal (opcional)
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
