{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    xkb.layout = "gb";
  };
  services.xserver.displayManager.sddm = {
    enable = true;
    defaultSession = "niri";
    theme = "chili";
  };
  environment.systemPackages = with pkgs; [
    sddm-chili-theme
  ];
}
