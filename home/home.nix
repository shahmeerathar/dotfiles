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
    oh-my-zsh = {
      enable = true;
      plugins = ["git" "fzf" "zoxide" "tldr" "man" "web-search" "eza"];
      custom = "/Users/shahmeerathar/.config/oh-my-zsh/";
    };
    initContent = ''
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
  };
  home.file.".p10k.zsh".source = ../configs/p10k/p10k.zsh;
  home.file.".config/oh-my-zsh".source = ../configs/oh-my-zsh;

  programs.tmux = {
    enable = true;
    plugins = [
      {
        plugin = tmux-nerd-font-window-name;
      }
    ];
  };
  catppuccin.tmux = {
    enable = true;
    extraConfig = "set -g @catppuccin_application_icon \"#(${tmux-nerd-font-window-name}/share/tmux-plugins/tmux-nerd-font-window-name/bin/tmux-nerd-font-window-name #{pane_current_command} 2)\"";
  };
  home.file.".tmux.conf".source = ../configs/tmux/tmux.conf;
  home.file.".config/tmux/tmux-nerd-font-window-name.yml".source = ../configs/tmux/tmux-nerd-font-window-name.yml;

  home.file.".config/aerospace".source = ../configs/aerospace;
  home.file.".config/ghostty".source = ../configs/ghostty;
  home.file.".config/kanata".source = ../configs/kanata;
  home.file.".config/nvim".source = ../configs/nvim;
  home.file.".vimrc".source = ../configs/vim/vimrc;
}
