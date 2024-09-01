{
lib,
pkgs,
...
}: 
let
  inherit (import ../../variables.nix) username editor browser;
in
{
  environment.variables = {
    STARSHIP_CONFIG = "/home/${username}/.config/starship/starship.toml";
    EDITOR = "${editor}";
    BROWSER = "${browser}";
    NIXPKGS_ALLOW_UNFREE = "1";
    QT_QPA_PLATFORM = "xcb";
    QT_QPA_PLATFORMTHEME = lib.mkForce "qt5ct";
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
  };
  environment.sessionVariables = rec{
    CLUTTER_BACKEND = "wayland";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    #GTK_THEME = "${config.colorscheme.slug}"; # sets default gtk theme the package built by nix-colors
    GTK_THEME = "Wallbash-Gtk";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    NIXOS_OZONE_WL = "1"; 
    XCURSOR_THEME = "Bibata-Modern-Ice"; 
  };
}
