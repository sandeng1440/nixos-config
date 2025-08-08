{pkgs, ...}:{
  home.packages = with pkgs; [
    libreoffice-fresh

    # security
    aircrack-ng
    wifite2
  ];
}
