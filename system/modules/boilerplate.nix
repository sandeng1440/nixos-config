{
pkgs,
...
}: {
  # Enable EnvFS
  services.envfs.enable = true;

  # Fix USB sticks not mounting or being listed:
  services.devmon.enable = true;
  services.udisks2.enable = true;
  services.gvfs.enable = true;

  # OpenGL
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];  
  };
  
  # Hardware
  #hardware.opengl.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # XDG Desktop Portal stuff
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    #gtkUsePortal = true;
    extraPortals = with pkgs; [ 
      xdg-desktop-portal-gtk xdg-desktop-portal-wlr 
      xdg-desktop-portal xdg-desktop-portal-hyprland
    ];
    configPackages = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
      xdg-desktop-portal
      xdg-desktop-portal-hyprland
    ];
  };

  # Printing support
  services.printing = {
    enable = true;
  };

  # Security / Polkit
  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        subject.isInGroup("users")
          && (
            action.id == "org.freedesktop.login1.reboot" ||
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
            action.id == "org.freedesktop.login1.power-off" ||
            action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          )
        )
      {
        return polkit.Result.YES;
      }
    })
  '';

  # Sound
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    wireplumber.enable = true;
    jack.enable = true; # (optional)
  };

  # DBus
  services.dbus.enable = true;

  # Locate
  services.locate = {
    enable = true;
  };
}
