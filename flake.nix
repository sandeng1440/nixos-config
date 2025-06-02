{
  description = "My new nixos explorateion";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devenv.url = "tarball+https://install.devenv.sh/latest";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, devenv, nixpkgs, home-manager, zen-browser, ... }:
    let inherit (import ./variables.nix) UserName HostName System;
    in {
      nixosConfigurations."${HostName}" = nixpkgs.lib.nixosSystem {
        system = "${System}";
        specialArgs = {
          inherit (nixpkgs) lib;
          inherit inputs;
        };
        modules = [ ./system ];
      };

    };
}
