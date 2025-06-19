{pkgs, ...}:{
  fonts.fontDir.enable = true;
  fonts.fontconfig.enable = true;
  fonts.packages = with pkgs; [
    dm-sans
    google-fonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    material-icons
    font-awesome
    symbola
    adwaita-fonts
    fira-code
    fira-code-symbols
    nerd-fonts.iosevka-term
    nerd-fonts.symbols-only
    nerd-fonts.jetbrains-mono
  ];
}
