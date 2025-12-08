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
    pkgs.nerd-fonts.symbols-only
    pkgs.ripgrep
    pkgs.tmux
    pkgs.yq
    pkgs.zoxide
  ];

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;

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

  home.file = {
    ".config/tmux/tmux-nerd-font-window-name.yml".source = ../configs/tmux/tmux-nerd-font-window-name.yml;
    ".config/nvim/init.lua".source = ../configs/nvim/init.lua;
    ".config/nvim/lua".source = ../configs/nvim/lua;
    ".config/vim".source = ../configs/vim;
  };
}
