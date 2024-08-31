{
lib,
inputs,
system,
config,
pkgs,
options,

username,
fullname,
hostname,
stateVersion,
timezone,
locale,
gitUsername,
gitEmail,
...
}: 
{
  imports = [
    ./hardware.nix
    ./modules/default.nix
  ];

  # Hostname
  networking.hostName = "${hostname}";
  networking.timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Set your time zone.
  time.timeZone = "${timezone}";

  # Select internationalisation properties.
  i18n.defaultLocale = "${locale}";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "${locale}";
    LC_IDENTIFICATION = "${locale}";
    LC_MEASUREMENT = "${locale}";
    LC_MONETARY = "${locale}";
    LC_NAME = "${locale}";
    LC_NUMERIC = "${locale}";
    LC_PAPER = "${locale}";
    LC_TELEPHONE = "${locale}";
    LC_TIME = "${locale}";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  environment.shells = with pkgs; [ zsh bash ];
  environment.localBinInPath = true;
  users.defaultUserShell = pkgs.zsh;  
  users.users.${username} = {
    isNormalUser = true;
    description = "${fullname}";
    extraGroups = ["networkmanager" "wheel" "video" "kvm"];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Programs
  programs = {
    hyprland = {
      enable = true;
      #package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      package = pkgs.hyprland;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
    };
    zsh = {
      enable = true;
      autosuggestions.enable = true;
      zsh-autoenv.enable = true;
      syntaxHighlighting.enable = true;
      ohMyZsh = {
        enable = true;
        theme = "refined";
        plugins = [ "git" "history" ];
      };
    };
    firefox.enable = true;
    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    virt-manager.enable = true;
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
    };
  };
  users = {
    mutableUsers = true;
  };

  # Services to start
  services = {
    xserver = {
      enable = false;
      #desktopManager.cinnamon.enable = false;
      xkb = {
        layout = "us";
        variant = "";
      };
    };
    smartd = {
      enable = true;
      autodetect = true;
    };
    libinput.enable = true;
    openssh.enable = true;
    flatpak.enable = true;
    #printing.enable = true;
    gnome.gnome-keyring.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    ipp-usb.enable = true;
    rpcbind.enable = true;
    nfs.server.enable = true;
    blueman.enable = true;
  };  

  # Virtualization / Containers
  virtualisation.libvirtd.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };
  
  #vm.guest-services.enable = false;
  #local.hardware-clock.enable = false;

  # Package overlays:
  nixpkgs.overlays = [
    (self: super: {
    })
  ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "${stateVersion}"; # Did you read the comment?
}
