{ config, pkgs, inputs, ... }:
let inherit (import ../variables.nix) hostname keymap locale timezone stateVersion;
in
{
  imports = [
    ./hardware.nix
    ../mod/nix-settings.nix
    ../mod/packages.nix
    ../mod/flatpak-packages.nix
    ../mod/fonts.nix
    ../mod/users.nix
    ../mod/services.nix
    ../mod/neovim.nix
    ../mod/security.nix
    ../mod/session-vars.nix
    ../mod/keepassxc.nix
    ../mod/display-manager.nix
    ../mod/zen-browser.nix
    ../mod/syncthing.nix
    ../mod/niri.nix
  ];

  gtk.iconCache.enable = true;
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    wlr.enable = true;
  };
  nixpkgs.config.allowUnfree = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  networking.hostName = "${hostname}";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  time.timeZone = "${timezone}";
  i18n.defaultLocale = "${locale}";
  console.keyMap = "${keymap}";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "${stateVersion}"; # Did you read the comment?
}
