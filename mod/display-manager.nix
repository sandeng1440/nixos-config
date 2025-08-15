{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    xkb.layout = "gb";
  };
  services.displayManager.sddm = {
    enable = true;
    theme = "sugar-dark";
  };
  environment.systemPackages = with pkgs; [
    libsForQt5.qt5.qtquickcontrols
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtsvg
    sddm-sugar-dark
  ];
}
