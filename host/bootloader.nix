{
  lib,
  config,
  pkgs,
  system,
  inputs,
  ...
}:

{
  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelModules = ["v4l2loopback"];
  boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
  boot.kernel.sysctl = {
    "vm.max_map_count" = 2147483642;
  };
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  # Bootloader settings
  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot";
  };
}
