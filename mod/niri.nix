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
    gtk-engine-murrine
    waybar
    swww
    dunst
    matugen
    gtk_engines
    papirus-icon-theme
    adw-gtk3
  ];
}
