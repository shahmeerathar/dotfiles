{
  config,
  pkgs,
  ...
}: let
  tmux-nerd-font-window-name =
    pkgs.tmuxPlugins.mkTmuxPlugin
    {
      pluginName = "tmux-nerd-font-window-name";
      version = "main";
      src = pkgs.fetchFromGitHub {
        owner = "joshmedeski";
        repo = "tmux-nerd-font-window-name";
        rev = "main";
        sha256 = "sha256-qP9pmJYbcGb1NiophTNexMF/nAQivqUENg8stsOERY4=";
      };
    };
in {
  home.username = "shahmeerathar";
  home.homeDirectory = "/Users/shahmeerathar";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  programs.git = {
    extraConfig = {
      core.editor = "nvim";
    };
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
  home.file.".config/p10k".source = ../configs/p10k;

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    baseIndex = 1;
    historyLimit = 5000;
    clock24 = true;
    extraConfig =
      builtins.readFile ../configs/tmux/tmux.conf
      + "set -g @catppuccin_application_icon \"#(${tmux-nerd-font-window-name}/share/tmux-plugins/tmux-nerd-font-window-name/bin/tmux-nerd-font-window-name #{pane_current_command} 1)\"\n"
      + "run-shell ${pkgs.tmuxPlugins.catppuccin}/share/tmux-plugins/catppuccin/catppuccin.tmux\n"
      + "run-shell ${tmux-nerd-font-window-name}/share/tmux-plugins/tmux-nerd-font-window-name/tmux-nerd-font-window-name.tmux\n";
  };
  home.file.".config/tmux/tmux-nerd-font-window-name.yml".source = ../configs/tmux/tmux-nerd-font-window-name.yml;

  home.file.".config/aerospace".source = ../configs/aerospace;
  home.file.".config/ghostty".source = ../configs/ghostty;
  home.file.".config/kanata".source = ../configs/kanata;
  home.file.".config/nvim".source = ../configs/nvim;
  home.file.".config/vim".source = ../configs/vim;
}
