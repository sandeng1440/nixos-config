{
description = "Santiago's nixos config";

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

outputs = inputs@{ self, nixpkgs, devenv, home-manager, zen-browser, ... }:
  let
    ##### WARNING: MAKE SURE YOU SET THESE VARIABLES TO THE CORRECT VALUES BEFORE BUILDING THE FLAKE
    fullname = "Test Accs";
    username = "test1";
    hostname = "void";
    systemArch = "x86_64-linux";

    timezone = "Africa/Nairobi";
    locale = "en_US.UTF-8";
    gitUsername = "hdengsan";
    gitEmail = "sanhenden@gmail.com";
    editor = "vim";
    browser = "brave";

    stateVersion = "23.11";
  in {
  nixosConfigurations = { 
    ${hostname} = nixpkgs.lib.nixosSystem rec {
      system = "${systemArch}";
      specialArgs = {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs;
        inherit system locale timezone;
        inherit username fullname hostname;
        inherit editor browser gitUsername gitEmail;
        inherit stateVersion;
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
    pkgs = nixpkgs.legacyPackages.${systemArch};
    modules = [ ./home.nix { home.packages = [ devenv.outputs.packages.${systemArch}.default ]; } ];
    extraSpecialArgs = {
      system = "${systemArch}";
      inherit username timezone gitUsername gitEmail;
      inherit hostname inputs locale stateVersion;
    };
  };
};
}
