{pkgs, ...}: let
  zshWithLocale = pkgs.symlinkJoin {
    name = "zsh-with-locale";
    paths = [pkgs.zsh];
    nativeBuildInputs = [pkgs.makeBinaryWrapper];
    postBuild = ''
      wrapProgram $out/bin/zsh \
        --set LOCALE_ARCHIVE "${pkgs.glibcLocales}/lib/locale/locale-archive"
    '';
    meta.mainProgram = "zsh";
  };
in {
  home = {
    username = "shahmeera";
    homeDirectory = "/cb/home/shahmeera";
  };

  programs.tmux.shell = "~/.nix-profile/bin/zsh";

  programs.zsh = {
    package = zshWithLocale;
    initContent = ''
      source ~/ws/scripts/rc.sh
    '';
  };
}
