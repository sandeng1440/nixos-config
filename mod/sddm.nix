{ pkgs, ... }: {
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sddm-astronaut-theme";
  };
  environment.systemPackages = with pkgs; [
    kdePackages.qtmultimedia
    kdePackages.qtvirtualkeyboard
    kdePackages.qtsvg
    kdePackages.qt5compat
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtquickcontrols2

    # sddm-astronaut
    (pkgs.sddm-astronaut {
      embeddedTheme = "black_hole";
    })
  ];
}
