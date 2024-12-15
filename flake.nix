{
  description = "Provides nix derivations for playwright browsers in various versions";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (system: 
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      {
        packages = {
          playwright-browsers_v1_45_0 = pkgs.callPackage ./v1_45_0/driver.nix { };
          default = self.packages.${system}.playwright-browsers_v1_45_0.playwright-core.browsers;
        };
      });
}
