{
  pkgs,
  username,
  hostname,
  stateVersion,
  ...
}:
let
  gitUsername = "hdengsan";
  gitEmail = "sanhenden@gmail.com";
in
{
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "${stateVersion}";
  };
  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      userName = "${gitUsername}";
      userEmail = "${gitEmail}";
    };
  };
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
