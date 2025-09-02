{ pkgs, ... }:
let inherit (import ../variables.nix) username;
in {
  fileSystems."/home/${username}/games" = {
    device = "/dev/disk/by-label/GAMES";
    fsType = "ext4";
  };
}
