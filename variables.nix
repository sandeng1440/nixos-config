# To build home-manager for the first time, run: `nix run home-manager -- -b bak switch --flake .`

# To rebuild home-manager after first build, run: `home-manager -b bak switch --flake .`

# NOTE: Make sure you are in this flake's directory.

{
  username = "santiago";
  fullname= "Santiago";
  hostname = "nixos";
  gitUsername = "sandeng1440";
  gitEmail = "sandeng1440@gmail.com";
  system = "x86_64-linux";
  timezone = "Africa/Nairobi";
  locale = "en_US.UTF-8";
  keymap = "uk";
  stateVersion = "25.05";
}
