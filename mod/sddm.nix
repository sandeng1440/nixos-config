{ pkgs, ... }: {
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "where_is_my_sddm_theme";
  };
  environment.systemPackages = with pkgs; [
    kdePackages.qtmultimedia
    kdePackages.qtvirtualkeyboard
    kdePackages.qtsvg
    kdePackages.qt5compat
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtquickcontrols2
    elegant-sddm
    where-is-my-sddm-theme

    # sddm-astronaut
    # (pkgs.sddm-astronaut.override {
    #   embeddedTheme = "black_hole";
    # })
  ];
}
