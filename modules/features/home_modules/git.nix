{ ... }: {
  flake.homeModules.git = { ... }: {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "Adriano Elias";
          email = "github@nano.slmail.me";
        };
      	alias = {
      	  st = "status";
      	  # lg = "log --oneline --graph --decorate";
      	  c = "commit -m";
      	  lg = "log --color --graph --branches --all --decorate --oneline";
      	  chb = "checkout -b";
      	  ch = "checkout";
      	};
        core.editor = "nvim";
        pull.rebase = true;
	      push.autoSetupRemote = true;
      };
    };
  };
}
