{pkgs, ...}: {
  imports = [./darwin.nix];

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
      dev = "ssh shahmeera@shahmeera-vm";
      io = "ssh shahmeera@ioasic16";
      asic = "ssh shahmeera@asic-hi3";
    };
  };
}
