{ pkgs, ... }: {
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    autoNumlock = true;
    theme = "Elegant";
    package = pkgs.kdePackages.sddm;
    extraPackages = [
      kdePackages.qtmultimedia
      kdePackages.qtvirtualkeyboard
      kdePackages.qtsvg
      kdePackages.qt5compat
      libsForQt5.qt5.qtgraphicaleffects
      libsForQt5.qt5.qtquickcontrols2
      elegant-sddm
    ];
  };
  environment.systemPackages = with pkgs; [
  ];
}
