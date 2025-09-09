{pkgs, ...}: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
    pkgs.aerospace
    pkgs.bat
    pkgs.alejandra
    pkgs.dust
    pkgs.eza
    pkgs.fd
    pkgs.fzf
    pkgs.kanata
    pkgs.neovim
    pkgs.oh-my-zsh
    pkgs.ripgrep
    pkgs.tmux
    pkgs.yq
    pkgs.zoxide
    pkgs.zsh-powerlevel10k
  ];

  homebrew = {
    enable = true;
    casks = [
      "ghostty"
      "logi-options+"
    ];
    onActivation.cleanup = "zap";
  };

  users.users.shahmeerathar = {
    name = "shahmeerathar";
    home = "/Users/shahmeerathar";
  };

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Set Git commit hash for darwin-version.
  system.configurationRevision = null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  programs.zsh.enable = true;
  programs.zsh.promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";

  system.primaryUser = "shahmeerathar";

  system.defaults = {
    NSGlobalDomain.AppleInterfaceStyle = "Dark";
    NSGlobalDomain.AppleICUForce24HourTime = true;
    menuExtraClock.Show24Hour = true;

    # Finder
    finder.ShowPathbar = true;
    finder.ShowStatusBar = true;
    finder.FXPreferredViewStyle = "clmv";
    finder.NewWindowTarget = "Home";
    finder.FXRemoveOldTrashItems = true;

    # Dock
    dock.autohide = true;
    dock.magnification = true;
    dock.tilesize = 64;
    dock.largesize = 72;
    dock.expose-group-apps = true;
    dock.mru-spaces = false;
    dock.wvous-br-corner = 1;
    dock.persistent-apps = [
      "/System/Applications/Music.app"
      "/System/Applications/Messages.app"
      "/System/Applications/Reminders.app"
      "/System/Applications/Calendar.app"
      # "/Applications/Obsidian.app"
      "/System/Applications/System Settings.app"
      "/System/Applications/Utilities/Activity Monitor.app"
      "/Applications/Ghostty.app"
      "/System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app"
      "/System/Applications/Photos.app"
      # "/Applications/Adobe Lightroom Classic.app"
      "/System/Applications/Maps.app"
      "/System/Applications/Home.app"
      "/System/Applications/iPhone Mirroring.app"
    ];

    # Trackpad
    trackpad.FirstClickThreshold = 2;
    trackpad.SecondClickThreshold = 2;
    trackpad.Clicking = true;
    NSGlobalDomain.AppleShowScrollBars = "WhenScrolling";
    NSGlobalDomain.AppleScrollerPagingBehavior = true;
    NSGlobalDomain."com.apple.swipescrolldirection" = false;

    # Keyboard
    NSGlobalDomain.InitialKeyRepeat = 15;
    NSGlobalDomain.KeyRepeat = 2;
  };
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;
}
