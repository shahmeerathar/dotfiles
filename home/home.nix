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
  tmux-kanagawa =
    pkgs.tmuxPlugins.mkTmuxPlugin
    {
      pluginName = "kanagawa";
      version = "master";
      src = pkgs.fetchFromGitHub {
        owner = "shahmeerathar";
        repo = "tmux-kanagawa";
        rev = "master";
        sha256 = "sha256-XyXP1BkV2QAFwr5AIdR6nQ6xjL5KJkuRr0j6iZkzEdA=";
      };
    };
in {
  home.stateVersion = "25.05";
  home.packages = [
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

  programs.git = {
    extraConfig = {
      core.editor = "nvim";
    };
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    baseIndex = 1;
    historyLimit = 5000;
    clock24 = true;
    plugins = [
      {
        plugin = tmux-kanagawa;
        extraConfig = ''
          set -g @kanagawa-theme 'dragon'
          set -g @kanagawa-show-flags true
          set -g @kanagawa-show-empty-plugins false
          set -g @kanagawa-git-disable-status false
          set -g @kanagawa-git-show-remote-status true
          set -g @kanagawa-show-ssh-only-when-connected true
          set -g @kanagawa-plugins "git ssh-session"
        '';
      }
    ];
    extraConfig =
      builtins.readFile ../configs/tmux/tmux.conf;
  };

  home.file = {
    ".config/tmux/tmux-nerd-font-window-name.yml".source = ../configs/tmux/tmux-nerd-font-window-name.yml;
    ".config/nvim/init.lua".source = ../configs/nvim/init.lua;
    ".config/nvim/lua".source = ../configs/nvim/lua;
    ".config/vim".source = ../configs/vim;
  };
}
