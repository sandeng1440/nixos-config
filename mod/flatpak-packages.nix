{pkgs, ...}: {
  services.flatpak.packages = [
    "us.zoom.Zoom"
    "com.github.tchx84.Flatseal"
    "com.icons8.Lunacy"
  ];
}
