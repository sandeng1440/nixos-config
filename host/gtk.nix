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
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
        size = 24;
        gtk.enable = true;
        x11.enable = true;
      };
    };

    gtk = {
      enable = true;
      theme = {
        name = "Wallbash-Gtk";
        #package = pkgs.cinnamon.mint-themes;
      };
      iconTheme = {
        name = "Tela-circle-dracula";
        package = pkgs.tela-circle-icon-theme;
      };
      font = {
        #name = "JetBrainsMono Nerd Font";
        name = "Cantarell";
        size = 11;
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
