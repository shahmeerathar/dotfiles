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
  home.stateVersion = "25.05";
  home.packages = [
    pkgs.oh-my-zsh
    pkgs.starship
    pkgs.bat
    pkgs.alejandra
    pkgs.dust
    pkgs.eza
    pkgs.fd
    pkgs.fzf
    pkgs.neovim
    pkgs.nerd-fonts.symbols-only
    pkgs.ripgrep
    pkgs.tmux
    pkgs.yq
    pkgs.zoxide
  ];

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    dotDir = config.xdg.cacheHome;
    oh-my-zsh = {
      enable = true;
      plugins = ["git" "fzf" "zoxide" "tldr" "man" "web-search" "eza"];
    };
    shellAliases = {
      tree = "ls --long --tree";
      findalias = "eval \$(alias | fzf | sed 's/=.*//')";
      fzfpreview = "fzf --preview=\"bat --color=always {}\" --height=100% --border=none --layout=default";
      vim = "vim -u $HOME/.config/vim/vimrc";
      vi = "vi -u $HOME/.config/vim/vimrc";
    };
    sessionVariables = {
      STARSHIP_CONFIG = "$HOME/.config/starship/starship.toml";
      FZF_DEFAULT_COMMAND = "fd --type f";
      FZF_DEFAULT_OPTS = "--height 40% --layout reverse --border";
      LESSHISTFILE = "$HOME/.cache/less/history";
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.git = {
    settings = {
      core.editor = "nvim";
      diff.tool = "nvimdiff";
      difftool.prompt = false;
      init.defaultBranch = "main";
    };
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    baseIndex = 1;
    historyLimit = 10000;
    clock24 = true;
    extraConfig =
      builtins.readFile ../configs/tmux/tmux.conf;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
    silent = true;
  };

  home.file = {
    ".config/tmux/tmux-nerd-font-window-name.yml".source = ../configs/tmux/tmux-nerd-font-window-name.yml;
    ".config/tmux/tmux-popup.sh".source = ../configs/tmux/tmux-popup.sh;
    ".config/tmux/tmux-popup.sh".executable = true;
    ".config/tmux/tmux-kill-orphan-popups.sh".source = ../configs/tmux/tmux-kill-orphan-popups.sh;
    ".config/tmux/tmux-kill-orphan-popups.sh".executable = true;
    ".config/nvim/init.lua".source = ../configs/nvim/init.lua;
    ".config/nvim/lua".source = ../configs/nvim/lua;
    ".config/vim".source = ../configs/vim;
    ".config/starship".source = ../configs/starship;
  };
}
