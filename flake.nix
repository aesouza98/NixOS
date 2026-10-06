{
  description = "NixOS configuration for nixos";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: {
    nixosConfigurations.nyx = nixpkgs.lib.nixosSystem {
      modules = [
        { nixpkgs.hostPlatform = "x86_64-linux"; }
        ./configuration.nix
      ];
    };
  };
}
