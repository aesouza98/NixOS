{ self, inputs, ... }:
{

  flake.nixosModules.fish =
    { ... }:
    {
      programs.fish = {
        enable = true;
        generateCompletions = true;
      };
    };
}
