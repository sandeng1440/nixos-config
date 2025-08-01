{pkgs, ...}:{
  imports = [
    ./polkit-gnome.nix
  ];
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  security.pam.services.swaylock = {};

  programs.niri.enable = true;
  environment.systemPackages = with pkgs; [
    fuzzel
    fastfetch
    networkmanagerapplet
    # xfce.mousepad
    libsForQt5.qt5ct
    xwayland-satellite
    mpd mpv ffmpeg
    swaynotificationcenter
    playerctl
    wl-clipboard-rs
    cliphist
    killall
    eww
    alacritty
    kitty
    file-roller
    zathura
    gthumb
    wlsunset
    ffmpegthumbnailer
    rofi-wayland
    swaylock-effects
    brightnessctl
    blueman
    pwvucontrol
    nwg-look
    # tela-icon-theme
    gtk-engine-murrine
    graphite-gtk-theme
    graphite-kde-theme
    waybar
    swww
    dunst
    matugen
    gtk_engines
    # flat-remix-gtk
    # papirus-folders
    papirus-icon-theme
    adw-gtk3
    # colloid-gtk-theme
    # colloid-icon-theme
  ];
}
