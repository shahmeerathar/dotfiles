{pkgs, ...}: {
  programs.git = {
    enable = true;
    userEmail = "shahmeer.athar@cerebras.net";
    userName = "Shahmeer Athar";
  };

  programs.zsh = {
    shellAliases = {
      dev = "ssh shahmeera@shahmeera-dev";
    };
  };
}
