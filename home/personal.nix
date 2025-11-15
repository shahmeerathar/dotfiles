{pkgs, ...}: {
  imports = [./darwin.nix];

  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "shahmeer.athar@gmail.com";
        name = "Shahmeer Athar";
      };
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
