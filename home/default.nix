{ pkgs, inputs, ... }:
let
  inherit (import ../variables.nix)
    UserName GitUserName GitEmail StateVersion System;
  zen = inputs.zen-browser.packages."${System}".default;

in {
  home = {
    homeDirectory = "/home/${UserName}";
    stateVersion = "${StateVersion}";

    packages = with pkgs; [
      #papirus-icon-theme
      #simple-cursors
      dconf
      "${zen}"
      tela-icon-theme
      tela-circle-icon-theme
      whitesur-icon-theme
      vimix-icon-theme
      qogir-icon-theme
      colloid-icon-theme
      adwaita-icon-theme
      colloid-gtk-theme
      gruvbox-material-gtk-theme
      graphite-gtk-theme
    ];
    pointerCursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 14;
      gtk.enable = true;
      x11.enable = true;
    };
  };
  gtk = {
    enable = true;
    theme = {
      name = "Flat-Remix-GTK-Red-Darkest";
      package = pkgs.flat-remix-gtk;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    font = {
      name = "Sans";
      size = 11;
    };
  };

  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      userName = "${GitUserName}";
      userEmail = "${GitEmail}";
    };
    # waybar = {
    #   enable = true;
    #   package = pkgs.waybar;
    # };
  };

  fonts.fontconfig.enable = true;
  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  dconf.enable = true;
  dconf.settings = {
    "org/gnome/desktop/interface".color-scheme = "prefer-dark";
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };
}
