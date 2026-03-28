{ self, inputs, ... }:
{

  flake.nixosModules.evince =
    { ... }:
    {
      programs.evince = {
        enable = true;
      };
    };
}
