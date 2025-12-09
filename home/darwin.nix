{pkgs, ...}: {
  home = {
    username = "shahmeerathar";
    homeDirectory = "/Users/shahmeerathar";
  };

  home.file = {
    ".config/aerospace".source = ../configs/aerospace;
    ".config/ghostty".source = ../configs/ghostty;
    ".config/kanata".source = ../configs/kanata;
    ".hushlogin" = {text = "";};
  };
}
