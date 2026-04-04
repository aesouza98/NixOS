{ ... }:
{
  flake.homeModules.fish =
    {
      config,
      lib,
      pkgs,
      utils,
      ...
    }:
    let
      user = config.home-manager.users.nano;
    in
    {
      programs.fish = {
        enable = true;
        vendor = {
          completions.enable = true;
          config.enable = true;
          functions.enable = true;
        };
      };
      home-manager."${user}" = {
        programs.fish = {
          enable = true;
          plugins = with pkgs.fishPlugins; [
            fzf-fish.src
            async-prompt.src
            fisher.src
            pure.src
          ];
        };
        programs.fzf.enableFishIntegration = false;
        home.packages = with pkgs; [
          fish
        ];
      };
    };
}
