{pkgs, ...}: {
  home = {
    username = "shahmeerathar";
    homeDirectory = "/Users/shahmeerathar";
  };

  programs.zsh = {
    enable = true;
    dotDir = "/Users/shahmeerathar/.cache/zsh";
    oh-my-zsh = {
      enable = true;
      plugins = ["git" "fzf" "zoxide" "tldr" "man" "web-search" "eza"];
    };
    initContent = ''
      [[ ! -f ~/.config/p10k/p10k.zsh ]] || source ~/.config/p10k/p10k.zsh
    '';
    shellAliases = {
      tree = "ls --long --tree";
      findalias = "eval \$(alias | fzf | sed 's/=.*//')";
      fzfpreview = "fzf --preview=\"bat --color=always {}\" --height=100% --border=none --layout=default";
      vim = "vim -u $HOME/.config/vim/vimrc";
      vi = "vi -u $HOME/.config/vim/vimrc";
    };
    sessionVariables = {
      FZF_DEFAULT_COMMAND = "fd --type f";
      FZF_DEFAULT_OPTS = "--height 40% --layout reverse --border";
      LESSHISTFILE = "$HOME/.cache/less/history";
    };
  };

  home.file = {
    ".config/aerospace".source = ../configs/aerospace;
    ".config/ghostty".source = ../configs/ghostty;
    ".config/kanata".source = ../configs/kanata;
    ".config/p10k".source = ../configs/p10k;
  };
}
