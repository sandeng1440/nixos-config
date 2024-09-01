{
description = "Santiago's nixos config";
outputs = inputs@{ self, nixpkgs, devenv, home-manager, zen-browser, ... }:
  let
    inherit (import ./variables.nix) hostname system username;
  in {
  nixosConfigurations = { 
    ${hostname} = nixpkgs.lib.nixosSystem rec {
      inherit system;
      specialArgs = {
        inherit (nixpkgs) lib;
        inherit inputs;
      };

      modules = [
        ./host/default.nix
        #inputs.home-manager.nixosModules.home-manager {
          #home-manager = {
            #useGlobalPkgs = true;
            #useUserPackages = true;
            #backupFileExtension = "backup";
            #users.${username} = import ./host/home.nix;
            #extraSpecialArgs = {
              #inherit username locale timezone;
              #inherit hostname gitUsername gitEmail;
              #inherit inputs system stateVersion;
            #};
          #};
        #}
      ];
    };
  };
  homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
    pkgs = nixpkgs.legacyPackages.${system};
    modules = [ ./home-manager/home.nix { home.packages = [ devenv.outputs.packages.${system}.default ]; } ];
    extraSpecialArgs = {
      inherit system inputs;
    };
  };
};

inputs = {
  nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
  home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  zen-browser.url = "github:MarceColl/zen-browser-flake";
  devenv.url = "tarball+https://install.devenv.sh/latest";
  #hyprland = {
    #url = "github:hyprwm/Hyprland";
    #url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
  #};
  #hyprland-plugins = {
    #url = "github:hyprwm/hyprland-plugins";
    #inputs.hyprland.follows = "hyprland";
  #}; 
  hyprwm-contrib = {
    url = "github:hyprwm/contrib";
    inputs.nixpkgs.follows = "nixpkgs";
  };
};
}
