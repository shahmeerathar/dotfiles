{pkgs, ...}: {
  homebrew.masApps = {
    "Adobe Lightroom" = 1451544217;
  };

  system.defaults = {
    dock.persistent-apps = [
      "/System/Applications/Music.app"
      "/System/Applications/Messages.app"
      "/System/Applications/Reminders.app"
      "/System/Applications/Calendar.app"
      "/Applications/Nix Apps/Obsidian.app"
      "/System/Applications/System Settings.app"
      "/System/Applications/Utilities/Activity Monitor.app"
      "/Applications/Ghostty.app"
      "/System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app"
      "/System/Applications/Photos.app"
      "/Applications/Adobe Lightroom.app"
      "/System/Applications/Maps.app"
      "/System/Applications/Home.app"
      "/System/Applications/iPhone Mirroring.app"
    ];
  };
}
