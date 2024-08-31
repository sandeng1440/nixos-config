{
pkgs,
username,
hostname,
stateVersion,
gitUsername,
gitEmail,
inputs,
system,
...
}:
{
imports = [
  ./home-nix.nix
];
home = 
let
  zen = inputs.zen-browser.packages."${system}".generic;
in
{
  username = "${username}";
  homeDirectory = "/home/${username}";
  stateVersion = "${stateVersion}";

  packages = with pkgs; [
    #papirus-icon-theme
    #simple-cursors
    dconf
    "${zen}"
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
  #font = {
    #name = "JetBrainsMono Nerd Font";
    #name = "Cantarell";
    #size = 11;
  #};
};
qt = {
  enable = true;
  platformTheme = "gtk";
  style = {
    name = "adwaita-dark";
    package = pkgs.adwaita-qt;
  };
};
programs = {
  home-manager.enable = true;
  git = {
    enable = true;
    userName = "${gitUsername}";
    userEmail = "${gitEmail}";
  };
  waybar = {
    enable = true;
    package = pkgs.waybar;
  };
};
fonts.fontconfig.enable = true;
xdg = {
  userDirs = {
    enable = true;
    createDirectories = true;
  };
};
dconf.settings = {
  "org/virt-manager/virt-manager/connections" = {
    autoconnect = [ "qemu:///system" ];
    uris = [ "qemu:///system" ];
  };
};
}
