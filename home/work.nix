{pkgs, ...}: {
  programs.git = {
    enable = true;
    userEmail = "shahmeer.athar@cerebras.net";
    userName = "Shahmeer Athar";
  };
}
