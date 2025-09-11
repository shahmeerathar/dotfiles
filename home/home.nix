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
    pkgs.bat
    pkgs.alejandra
    pkgs.dust
    pkgs.eza
    pkgs.fd
    pkgs.fzf
    pkgs.neovim
    pkgs.ripgrep
    pkgs.tmux
    pkgs.yq
    pkgs.zoxide
  ];

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
    extraConfig =
      builtins.readFile ../configs/tmux/tmux.conf
      + "set -g @catppuccin_application_icon \"#(${tmux-nerd-font-window-name}/share/tmux-plugins/tmux-nerd-font-window-name/bin/tmux-nerd-font-window-name #{pane_current_command} 1)\"\n"
      + "run-shell ${pkgs.tmuxPlugins.catppuccin}/share/tmux-plugins/catppuccin/catppuccin.tmux\n"
      + "run-shell ${tmux-nerd-font-window-name}/share/tmux-plugins/tmux-nerd-font-window-name/tmux-nerd-font-window-name.tmux\n";
  };

  home.file = {
    ".config/tmux/tmux-nerd-font-window-name.yml".source = ../configs/tmux/tmux-nerd-font-window-name.yml;
    ".config/nvim".source = ../configs/nvim;
    ".config/vim".source = ../configs/vim;
  };
}
