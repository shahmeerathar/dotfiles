{pkgs, ...}: let
  spyder = pkgs.stdenv.mkDerivation rec {
    name = "spyder";
    pname = "spyder";

    src = pkgs.fetchurl {
      url = "https://dci-industrial-downloads.azureedge.net/spyder/Spyder_6.3.1.pkg.zip";
      sha256 = "sha256-Jy/uzyer/m6QJnF0AspTJ2q53hNlS4zSBZ+Mk1K6xYc=";
      curlOpts = "-L -H Accept:application/octet-stream";
    };

    nativeBuildInputs = with pkgs; [unzip xar cpio];

    unpackPhase = ''
      unzip $src
      xar -xf Spyder_6.3.1.pkg
      cd Spyder.pkg
      cat Payload | gunzip -dc | cpio -i
    '';

    installPhase = ''
      mkdir -p $out/Applications
      cp -r Applications/* $out/Applications/
    '';
  };
in {
  environment.systemPackages = [
    spyder
    pkgs.iina
  ];
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
