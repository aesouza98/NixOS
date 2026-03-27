{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake 
	{inherit inputs;}
	{
      # This tells flake-parts to collect all 'homeModules' from 
      # your sub-modules and merge them into the final flake output.
      flake.homeModules = { };

      # This imports your existing module tree
      imports = [ (inputs.import-tree ./modules) ];
    };
}
