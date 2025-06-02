{ inputs, pkgs, ... }:
let
  inherit (import ../variables.nix) System UserName;
  zen = inputs.zen-browser.packages."${System}".twilight;
in {
  programs = {
    hyprland = {
      enable = true;
      # withUWSM = true;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
    };
    localsend = {
      enable = true;
      openFirewall = true;
    };
    # neovim = {
    #   enable = true;
    #   defaultEditor = true;
    #   vimAlias = true;
    #   viAlias = true;
    # };
    # waybar.enable = true;
    starship.enable = true;
    firefox.enable = true;
    fish.enable = true;
    fuse.userAllowOther = true;
    chromium.enable = true;
    mtr.enable = true;
    dconf.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-media-tags-plugin
        thunar-vcs-plugin
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };
  fonts.fontDir.enable = true;
  fonts.fontconfig.enable = true;
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk-sans
    nerd-fonts.zed-mono
    nerd-fonts.ubuntu-mono
    nerd-fonts.ubuntu
    nerd-fonts.symbols-only
    nerd-fonts.tinos
    nerd-fonts.iosevka
    nerd-fonts.jetbrains-mono
    nerd-fonts.caskaydia-cove
    nerd-fonts.mononoki
    symbola
    noto-fonts-color-emoji
    material-icons
    font-awesome
    atkinson-hyperlegible
    cascadia-code
  ];
  users.users.${UserName}.packages = with pkgs; [ tree ];
  environment.systemPackages = with pkgs; [
    zen

    # themes
    tela-icon-theme
    adw-gtk3
    wallust
    tela-circle-icon-theme
    whitesur-icon-theme
    vimix-icon-theme
    qogir-icon-theme
    colloid-icon-theme
    adwaita-icon-theme
    colloid-gtk-theme
    gruvbox-material-gtk-theme
    graphite-gtk-theme
    bibata-cursors
    yaru-theme
    morewaita-icon-theme

    vimPlugins.LazyVim
    coreutils
    texlivePackages.latexmk
    biber
    sqlite
    lazygit
    ghostscript
    waybar
    firefox
    grim
    slurp
    cliphist
    rofi-emoji
    rofi-wayland
    networkmanagerapplet
    eww
    virt-manager
    mpv
    nodePackages.nodejs
    python3Full
    vimPlugins.nvim-treesitter.withAllGrammars
    jq
    qt5.qtwayland
    qt6.qtwayland
    gthumb
    qt6.qmake
    procps
    xdg-utils
    libsForQt5.qt5ct
    kdePackages.qt6ct
    starship
    mpv
    blueman
    bat
    gsettings-qt
    qtcreator
    tldr
    dconf
    killall
    gtk2
    gtk3
    gtk4
    ffmpeg
    ffmpegthumbnailer
    bluez
    bluez-tools
    pkg-config
    usbutils
    fzf
    ripgrep
    nwg-look
    yazi
    brave
    keepassxc
    wl-clipboard-rs
    kdePackages.qtstyleplugin-kvantum
    lua51Packages.lua
    lua54Packages.luarocks
    imagemagick
    neovim
    go
    fd
    eza
    gcc
    rustup
    brightnessctl
    git
    zathura
    wget
    kitty
    zip
    unzip
    rar
    unrar
    gnutar
    gnumake
    pwvucontrol
    xdg-desktop-portal-hyprland
    hyprnotify
    hypridle
    hyprlock
    hyprcursor
    hyprgraphics
    hyprpicker
    hyprsunset
    hyprpaper
    hyprls
    hyprshot
    hyprpolkitagent
    hyprland
    # Ags setup deps
    matugen
    ags_1
    gtk-session-lock
    dart-sass
    webkitgtk_4_1
    astal.auth
    # astal.io
    # astal.gjs
    # astal.tray
    # astal.cava
    # astal.mpris
    # astal.astal4
    # astal.notifd
    playerctl
    libgtop
    cage
    vala
    kanshi
    pw-volume
    brotab
    sptlrx
    cava
    vte
    wezterm
    nautilus

    # HyDE deps
    # dunst
    wlogout
    parallel-full
    kdePackages.ffmpegthumbs
    kdePackages.qtimageformats
    kdePackages.kde-cli-tools
    kdePackages.dolphin
    kdePackages.ark
    nwg-displays
    ddcui
    swww
  ];
}
