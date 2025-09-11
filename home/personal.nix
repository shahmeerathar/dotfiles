{pkgs, ...}: {
  programs.git = {
    enable = true;
    userEmail = "shahmeer.athar@gmail.com";
    userName = "Shahmeer Athar";
    extraConfig = {
      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "~/.ssh/id_ed25519.pub";
    };
  };

  programs.zsh = {
    shellAliases = {
      dev = "cd ~/Developer";
    };
  };
}
