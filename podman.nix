{ pkgs, ... }:
{
  # podman rootless (servidor PW local em ~/Games/pw-server)
  virtualisation.podman = {
    enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  environment.systemPackages = with pkgs; [
    podman-compose
  ];
}
