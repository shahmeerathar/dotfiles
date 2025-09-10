{
  description = "Shahmeer's Nix config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    home-manager,
    nix-homebrew,
    catppuccin,
  }: let
    mkDarwinConfig = extraModules: homeConfig:
      nix-darwin.lib.darwinSystem {
        modules =
          [
            ./darwin/darwin.nix
            home-manager.darwinModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.shahmeerathar = {
                  imports = [
                    ./home/home.nix
                    homeConfig
                    catppuccin.homeModules.catppuccin
                  ];
                };
              };
              nixpkgs = {config.allowUnfree = true;};
            }
            nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                enable = true;
                enableRosetta = false;
                user = "shahmeerathar";
              };
            }
          ]
          ++ extraModules;
      };
  in {
    darwinConfigurations."Shahmeers-MacBook-Pro" = mkDarwinConfig [./darwin/personal.nix] ./home/personal.nix;
    darwinConfigurations."Shahmeers-Work-MacBook-Pro" = mkDarwinConfig [./darwin/work.nix] ./home/work.nix;
  };
}
