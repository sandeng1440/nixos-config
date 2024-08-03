{
  pkgs,
  config,

  username,
  ...
}: {
  home-manager.users.${username} = {
    home = {
      packages = with pkgs; [
        dconf
        # gnome.dconf-editor
      ];

      pointerCursor = {
        name = "Simp1e-Gruvbox-Light";
        package = pkgs.simp1e-cursors;
        size = 24;
        gtk.enable = true;
        x11.enable = true;
      };
    };

    gtk = {
      enable = true;
      theme = {
        name = "Mint-Y-Dark-Teal";
        package = pkgs.cinnamon.mint-themes;
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
      font = {
        name = "JetBrainsMono Nerd Font";
        size = 14;
      };
      gtk3 = {
        extraConfig = {
          gtk-application-prefer-dark-theme = 1;
        };
      };
      gtk4 = {
        extraConfig = {
          gtk-application-prefer-dark-theme = 1;
        };
      };
    };
  };
}
