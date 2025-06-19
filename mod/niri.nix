{pkgs, ...}:{
  imports = [
    ./polkit-gnome.nix
  ];
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  security.pam.services.swaylock = {};

  programs.niri.enable = true;
  environment.systemPackages = with pkgs; [
  ];
}
