{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    xkb.layout = "gb";
  };
  services.xserver.displayManager.sddm = {
    enable = true;
    theme = "chili";
  };
  environment.systemPackages = with pkgs; [
    libsForQt5.qt5.qtquickcontrols2
    sddm-chili-theme
  ];
}
