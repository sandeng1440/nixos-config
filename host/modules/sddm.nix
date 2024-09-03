{pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    kdePackages.sddm sddm 
    sddm-chili-theme
    where-is-my-sddm-theme
    (catppuccin-sddm.override {
      flavor = "mocha";
      #font = "Noto Sans";
      #fontSize = "14";
      #background = "${./sddm-wall.png}";
      #loginBackground = true;
    })
  ];
  services.xserver.displayManager.sddm = {
    enable = true;
    autoNumlock = true;
    enableHidpi = true;
    wayland.enable = true;
    theme = "chili";
    package = pkgs.sddm;
  };
}
