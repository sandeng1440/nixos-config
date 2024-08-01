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
    #./gtk.nix
    ./nix.nix
    ./boilerplate.nix
    ./bootloader.nix
    ./env-vars.nix
  ];

  # Kernel.
  boot.kernelPackages = pkgs.linuxPackages_zen;
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
    packages = with pkgs; [
      # Put your packages here
      # obsidian neovim stow
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #### Core Packages
    lld gcc glibc clang udev llvmPackages.bintools
    wget procps killall zip unzip bluez
    bluez-tools brightnessctl light xdg-utils
    pipewire wireplumber alsaLib pkg-config
    kdePackages.qtsvg elegant-sddm catppuccin-sddm-corners
    (callPackage ../../pkgs/sddm-theme.nix {}).corners
    (catppuccin-sddm.override {
      flavor = "mocha";
      #font = "Noto Sans";
      #fontSize = "14";
      #background = "${./sddm-wall.png}";
      #loginBackground = true;
    })

    #### Standard Packages
    networkmanager networkmanagerapplet
    git fzf vim tldr sox yad flatpak
    ffmpeg neovim

    #### GTK
    gtk2 gtk3 gtk4

    #### QT
    qtcreator
    qt5.qtwayland qt6.qtwayland qt6.qmake
    libsForQt5.qt5.qtwayland qt5ct

    #### My Packages
    helix xfce.thunar bat
    cava neofetch cpufetch starship lolcat
    transmission-gtk slurp vlc mpv krabby
    zellij shellcheck thefuck gthumb cmatrix
    lagrange lavat

    ## Xorg Libraries
    xorg.libX11
    xorg.libXcursor

    ## Other Hyprdots dependencies
    hyprland waybar xwayland cliphist alacritty swww
    swaynotificationcenter lxde.lxsession gtklock
    eww xdg-desktop-portal-hyprland
    inputs.hyprwm-contrib.packages.${system}.grimblast
    where-is-my-sddm-theme firefox brave
    pavucontrol blueman trash-cli ydotool
    lsd parallel pwvucontrol pamixer udiskie dunst swaylock-effects
    wlogout hyprpicker slurp swappy polkit_gnome libinput-gestures
    xdg-desktop-portal-hyprland jq kdePackages.qtimageformats
    kdePackages.ffmpegthumbs kdePackages.kde-cli-tools libnotify
    kdePackages.sddm libsForQt5.qt5.qtquickcontrols libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum kdePackages.qtstyleplugin-kvantum
    kdePackages.qt6ct kdePackages.wayland rofi-wayland nwg-look ark
    dolphin kitty eza oh-my-zsh zsh zsh-powerlevel10k
    pokemon-colorscripts-mac envsubst
    imagemagick gnumake tree
    papirus-icon-theme
  ];

  # Font stuff:
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    noto-fonts noto-fonts-emoji noto-fonts-cjk
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
    symbola noto-fonts-color-emoji material-icons
    font-awesome atkinson-hyperlegible
  ];


  # Programs
  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
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
    displayManager.sddm = {
        enable = true;
        autoNumlock = true;
        enableHidpi = true;
        wayland.enable = true;
        theme = "catppuccin-mocha";
        package = pkgs.kdePackages.sddm;
    };
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

  #drivers.intel.enable = true;
  #vm.guest-services.enable = false;
  #local.hardware-clock.enable = false;

  # Home manager options
  home-manager.users.${username} = {
    programs.waybar = {
      enable = true;
      #package = inputs.hyprland.packages.${system}.waybar-hyprland;
      package = pkgs.waybar;
    };
  };

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
