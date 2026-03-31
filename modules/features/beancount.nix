{ self, inputs, ... }:
{

  flake.nixosModules.beancount =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.beancount
        pkgs.beancount-language-server
        pkgs.fava
      ];
      environment.shellAliases = {
        bcheck = "bean-check ~/Documents/Beancount/main.bean";
        bformat = "bean-format -c 60 ~/Documents/Beancount/main.bean";
      };
      systemd.user.services.fava = {
        description = "Fava Web Interface for Beancount";
        wantedBy = [ "default.target" ];
        after = [ "network.target" ];
        serviceConfig = {
          ExecStart = "${pkgs.fava}/bin/fava %h/Documents/Beancount/main.bean --host 127.0.0.1 --port 5000";
          Restart = "on-failure";
        };
      };
    };
}
