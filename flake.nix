{
description = "Santiago's nixos config";

inputs = {
  nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
  home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  hyprland = {
    url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
  };
  hyprland-plugins = {
    url = "github:hyprwm/hyprland-plugins";
    inputs.hyprland.follows = "hyprland";
  }; 
  hyprwm-contrib = {
    url = "github:hyprwm/contrib";
    inputs.nixpkgs.follows = "nixpkgs";
  };
};

outputs = inputs@{ self, nixpkgs, ... }: {
  nixosConfigurations = 
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
    # Do not change this value
    stateVersion = "23.11";
  in 
  {
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
        inputs.home-manager.nixosModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
            users.${username} = import ./host/home.nix;
            extraSpecialArgs = {
              inherit username locale timezone;
              inherit hostname gitUsername gitEmail;
              inherit inputs;
              inherit system;
              inherit stateVersion;
            };
          };
        }
      ];
    };
  };
};
}
