{ self, inputs, ... }:
{

  flake.nixosModules.fish =
    { pkgs, ... }:
    {
      programs.fish = {
        enable = true;
        generateCompletions = true;
      };
      environment.systemPackages = with pkgs.fishPlugins; [
        fzf-fish
        async-prompt
        pure
      ];
    };
}
