{ self, inputs, ... }:
{

  flake.nixosModules.ssh =
    { pkgs, ... }:
    {
      # Enable the SSH agent globally
      programs.ssh.startAgent = true;

      # Optional: Install key management tools
      environment.systemPackages = with pkgs; [
        git
        openssh
      ];
      services.gnome.gnome-keyring.enable = true; # Keep the keyring for passwords
      services.gnome.gcr-ssh-agent.enable = false; # But disable its SSH agent
    };
}
