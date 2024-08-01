{
  lib,
  config,
  pkgs,
  system,
  inputs,
  ...
}:

{
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  # Bootloader settings
  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot";
  };
}
