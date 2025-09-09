{
  config,
  pkgs,
  ...
}: {
  home.username = "shahmeerathar";
  home.homeDirectory = "/Users/shahmeerathar";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = ["git" "fzf" "zoxide" "tldr" "man" "web-search" "eza"];
      custom = "/Users/shahmeerathar/.oh-my-zsh/custom/";
    };
    initContent = ''
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
  };
}
