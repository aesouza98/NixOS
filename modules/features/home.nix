{ lib, ... }: {
  # We use 'options' here, but we target the 'flake' submodule 
  # that flake-parts already knows about.
  options.flake = {
    homeModules = lib.mkOption {
      type = lib.types.attrsOf lib.types.deferredModule;
      default = {};
      description = "Home Manager modules exported by this flake.";
    };
  };
}
