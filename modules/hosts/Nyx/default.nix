{ self, inputs, ... }:
{
  flake.nixosConfigurations.Nyx = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.NyxConfig
    ];
  };
}
