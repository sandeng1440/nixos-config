{
  pkgs,
  inputs,
  system,
  ...
}:
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #### Core Packages
    lld gcc glibc clang udev llvmPackages.bintools
    wget procps killall zip unzip bluez busybox
    bluez-tools brightnessctl light xdg-utils
    pipewire wireplumber alsaLib pkg-config
    kdePackages.qtsvg usbutils lxqt.lxqt-policykit    

    # sddm
    kdePackages.sddm 
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
    gtk2 gtk3 gtk4 tela-circle-icon-theme
    bibata-cursors

    #### QT
    qtcreator
    qt5.qtwayland qt6.qtwayland qt6.qmake
    libsForQt5.qt5.qtwayland qt5ct
    gsettings-qt

    #### My Packages
    helix xfce.thunar bat discord
    cava neofetch cpufetch starship lolcat
    transmission_4-gtk slurp vlc mpv krabby
    zellij shellcheck thefuck gthumb cmatrix
    lagrange lavat localsend obs-studio obsidian

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
    libsForQt5.qt5.qtquickcontrols libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum kdePackages.qtstyleplugin-kvantum
    kdePackages.qt6ct kdePackages.wayland rofi-wayland nwg-look ark
    dolphin kitty eza oh-my-zsh zsh zsh-powerlevel10k
    pokemon-colorscripts-mac envsubst hyprcursor
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
}
