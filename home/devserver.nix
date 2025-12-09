{pkgs, ...}: {
  home = {
    username = "shahmeera";
    homeDirectory = "/cb/home/shahmeera";
  };

  programs.tmux.shell = "~/.nix-profile/bin/zsh";

  programs.zsh.initContent = ''
    source ~/ws/scripts/rc.sh
  '';
}
