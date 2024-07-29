{
  pkgs,
  username,
  hostname,
  stateVersion,
  gitUsername,
  gitEmail,
  ...
}:
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
