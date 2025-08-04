{pkgs, config, inputs, ...}:
let inherit (import ../variables.nix) username gitEmail gitUsername stateVersion;
in{
  imports = [
    # ./neovim.nix
    # ./systemd-units.nix
    # ./packages.nix
    # ./hyprland.nix
    # ../dotfiles/dotfiles.nix
    # ./niri.nix
  ];


  gtk = {
    enable = true;
    # theme = {
    #   name = "Graphite-Dark";
    #   package = pkgs.graphite-gtk-theme;
    # };
    # iconTheme = {
    #   name = "Papirus-Dark";
    #   package = pkgs.papirus-icon-theme;
    # };
    # font = {
    #   name = "Radio Canada Regular";
    #   size = 11;
    # };
    # cursorTheme = {
    #   size = 21;
    #   name = "graphite-dark";
    #   package = pkgs.graphite-cursors;
    # };
  };

  qt = {
    enable = true;
    # platformTheme.name = "kde";
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
      gtk.enable = true;
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
