{pkgs, config, inputs, ...}:
let inherit (import ../variables.nix) username gitEmail gitUsername stateVersion;
in{
  imports = [
    ./packages.nix
    # ./neovim.nix
    # ./systemd-units.nix
    # ./hyprland.nix
    # ../dotfiles/dotfiles.nix
    # ./niri.nix
  ];

  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    font = {
      name = "Adwaita Sans Regular";
      size = 10;
    };
    # cursorTheme = {
    #   size = 21;
    #   name = "graphite-dark";
    #   package = pkgs.graphite-cursors;
    # };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk2";
    style.name = "kvantum";
    # style.package = pkgs.graphite-kde-theme;
  };
  fonts.fontconfig.enable = true;
  programs = {
    git = {
      enable = true;
      userName = "${gitUsername}";
      userEmail = "${gitEmail}";
    };
    home-manager.enable = true;
  };
  home = {
    pointerCursor = {
      enable = true;
      # gtk.enable = true;
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 21;
      x11.enable = true;
    };
    username = "${username}";
    homeDirectory = "/home/${username}";
  };
  home.stateVersion = "${stateVersion}";
}
