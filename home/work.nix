{pkgs, ...}: {
  imports = [./darwin.nix];

  home.packages = [
    pkgs.mosh
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "shahmeer.athar@cerebras.net";
        name = "Shahmeer Athar";
      };
    };
  };

  programs.zsh = {
    shellAliases = {
      dev = "mosh shahmeera@shahmeera-vm";
      io = "mosh shahmeera@ioasic16";
      asic = "mosh shahmeera@asic-hi3";
    };
  };
}
