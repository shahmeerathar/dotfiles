{
  description = "Shahmeer's Nix config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    home-manager,
    nix-homebrew,
  }: let
    darwinConfig = import ./darwin.nix;
    homeConfig = import ./home.nix;
  in {
    darwinConfigurations."Shahmeers-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      modules = [
        darwinConfig
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.shahmeerathar = homeConfig;
        }
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            enableRosetta = false;
            user = "shahmeerathar";
          };
        }
        {system.configurationRevision = self.rev or self.dirtyRev or null;}
      ];
    };
  };
}
