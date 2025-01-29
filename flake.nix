{
  description = "nix-on-droid flake";

  inputs = {
    # Nix
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # home-manager = {
    #   url = "github:nix-community/home-manager/release-24.11";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
      # inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    nix-on-droid,
    ...
  }@inputs:
    let
      system = "aarch64-linux";
      hostname = "localhost";
      username = "nix-on-droid";
    in
    nix-on-droid.lib.nixOnDroidConfiguration.default {
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ nix-on-droid.overlays.default ];
      };
      unstablePkgs = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
        overlays = [ nix-on-droid.overlays.default ];
      };
      extraSpecialArgs = {
        inherit inputs system hostname username;
      };
      modules = [
        ./nix-on-droid.nix
      ];
    };
}
