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
    pkgs.mas
    pkgs.monitorcontrol
    pkgs.neovim
    pkgs.obsidian
    pkgs.oh-my-zsh
    pkgs.raycast
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
    masApps = {
      "AdBlock for Safari" = 1402042596;
      "Amphetamine" = 937984704;
      "PCalc" = 403504866;
    };
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

    # Trackpad
    trackpad.FirstClickThreshold = 2;
    trackpad.SecondClickThreshold = 2;
    trackpad.Clicking = true;
    NSGlobalDomain.AppleShowScrollBars = "WhenScrolling";
    NSGlobalDomain.AppleScrollerPagingBehavior = true;
    NSGlobalDomain."com.apple.swipescrolldirection" = false;

    # Keyboard
    NSGlobalDomain.InitialKeyRepeat = 10;
    NSGlobalDomain.KeyRepeat = 1;
  };

  launchd.daemons."com.shahmeerathar.kanata".serviceConfig = {
    ProgramArguments = ["/run/current-system/sw/bin/kanata" "-c" "/Users/shahmeerathar/.config/kanata/kanata.kbd"];
    RunAtLoad = true;
    KeepAlive = true;
    StandardOutPath = "/Library/Logs/Kanata/kanata.out.log";
    StandardErrorPath = "/Library/Logs/Kanata/kanata.err.log";
  };

  launchd.daemons."com.shahmeerathar.karabiner-vhiddaemon".serviceConfig = {
    ProgramArguments = ["/Library/Application Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/Applications/Karabiner-VirtualHIDDevice-Daemon.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Daemon"];
    RunAtLoad = true;
    KeepAlive = true;
  };

  launchd.daemons."com.shahmeerathar.karabiner-vhidmanager".serviceConfig = {
    ProgramArguments = ["/Library/Application Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/Applications/Karabiner-VirtualHIDDevice-Daemon.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Daemon" "activate"];
    RunAtLoad = true;
  };
}
