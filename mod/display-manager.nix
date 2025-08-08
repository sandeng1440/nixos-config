{ pkgs, ... }: {
  # LightDM
  # services.xserver = {
  #   enable = true;
  #   xkb.layout = "gb";
  # };
  # services.displayManager.defaultSession = "niri";
  # services.xserver.displayManager = {
  #   lightdm = {
  #     enable = true;
  #     greeters.slick.enable = true;
  #   };
  # };

  # SDDM
  services.displayManager.sddm = {
    enable = true;
    # wayland.enable = true;
    # wayland.compositor = "weston";
    autoNumlock = true;
    theme = "Elegant";
    package = pkgs.kdePackages.sddm;
  };
  environment.systemPackages = with pkgs; [
    kdePackages.qtmultimedia
    kdePackages.qtvirtualkeyboard
    kdePackages.qtsvg
    kdePackages.qt5compat
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtquickcontrols2
    elegant-sddm
  ];
}
