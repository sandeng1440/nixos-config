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
    sddm-chili-theme
  ];
}
