{pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    kdePackages.sddm sddm
    where-is-my-sddm-theme
    (catppuccin-sddm.override {
      flavor = "mocha";
      #font = "Noto Sans";
      #fontSize = "14";
      #background = "${./sddm-wall.png}";
      #loginBackground = true;
    })
  ];
  services.displayManager.sddm = {
    enable = true;
    autoNumlock = true;
    enableHidpi = true;
    wayland.enable = true;
    theme = "catppuccin-mocha";
    package = pkgs.kdePackages.sddm;
  };
}
