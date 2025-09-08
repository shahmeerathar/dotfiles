{
  description = "Shahmeer's Nix config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    nix-homebrew,
  }: let
    darwinConfig = import ./darwin.nix;
  in {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Shahmeers-MacBook-Pro
    darwinConfigurations."Shahmeers-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      modules = [
        darwinConfig
        {system.configurationRevision = self.rev or self.dirtyRev or null;}
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            enableRosetta = false;
            user = "shahmeerathar";
          };
        }
      ];
    };
  };
}
