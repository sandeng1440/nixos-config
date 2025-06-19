{ pkgs, ... }: {
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "Graphite";
    package = pkgs.libsForQt5.sddm;
  };
  environment.systemPackages = with pkgs; [
    kdePackages.qtmultimedia
    kdePackages.qtvirtualkeyboard
    kdePackages.qtsvg
    kdePackages.qt5compat
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtquickcontrols2
    sddm-chili-theme
    graphite-kde-theme
    # sddm-astronaut
    # (pkgs.where-is-my-sddm-theme.override {
    #   themeConfig.General = {
    #     background = (builtins.toString ./sddm-background.png);
    #   };
    # })
  ];
}
