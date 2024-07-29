{
  lib,
  system,
  config,
  pkgs,
  inputs,

  username,

  editor,
  browser,
  ...
}: {
  environment.variables = {
    STARSHIP_CONFIG = "/home/${username}/.config/starship/starship.toml";
    EDITOR = "${editor}";
    BROWSER = "${browser}";
    NIXPKGS_ALLOW_UNFREE = "1";
    QT_QPA_PLATFORM = "xcb";
    QT_QPA_PLATFORMTHEME = lib.mkForce "qt5ct";
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
  };
}
