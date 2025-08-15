{pkgs, ...}:
let inherit (import ../variables.nix) username;
in {
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    user = "${username}";
    dataDir = "/home/${username}";
    configDir = "/home/${username}/.config/syncthing";
  };
}
