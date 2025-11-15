{pkgs, ...}: {
  imports = [./darwin.nix];

  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "shahmeer.athar@cerebras.net";
        name = "Shahmeer Athar";
      };
    };
  };

  programs.zsh = {
    shellAliases = {
      dev = "ssh shahmeera@shahmeera-dev";
    };
  };
}
