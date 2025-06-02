{ pkgs, ... }:
let inherit (import ../variables.nix) UserName;
in {
  services = {
    qemuGuest.enable = true;
    spice-vdagentd.enable = true;
    spice-webdavd.enable = true;
    tumbler.enable = true;
    gvfs.enable = true;
    devmon.enable = true;
    syncthing = {
      enable = true;
      openDefaultPorts = true;
      user = "${UserName}";
      dataDir = "/home/${UserName}";
      configDir = "/home/${UserName}/.config/syncthing";
    };
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      wireplumber.enable = true;
    };
    rpcbind.enable = false;
    nfs.server.enable = false;
    envfs.enable = true;
    gnome.gnome-keyring.enable = true;
    blueman.enable = true;
    udisks2.enable = true;
    openssh.enable = true;
    dbus.enable = true;
    libinput.enable = true;
    flatpak.enable = true;
  };
  systemd.oomd.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
}
