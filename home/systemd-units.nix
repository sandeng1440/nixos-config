{pkgs,...}:{
  systemd.user.services = {
    swww-daemon = {
      description = "swww wallpaper daemon";
      wantedBy = [ "graphical-session.target" ]; # Start with graphical session
      after = [ "graphical-session-pre.target" ]; # Ensure it starts after session prep
      serviceConfig = {
        ExecStart = "${pkgs.swww}/bin/swww-daemon";
        Restart = "always";
        RestartSec = 5;
      };
      environment = {
        XDG_RUNTIME_DIR = "/run/user/$UID";
      };
    };
    # eww = {
    #   description = "ElKowar's Wacky Widgets (eww) daemon for Wayland";
    #   wantedBy = [ "graphical-session.target" ];
    #   after = [ "graphical-session-pre.target" "swww-daemon.service" ];
    #   serviceConfig = {
    #     ExecStart = "${pkgs.eww}/bin/eww daemon --no-daemonize";
    #     ExecStartPost = "${pkgs.eww}/bin/eww open bar";
    #     Restart = "always";
    #     RestartSec = 5;
    #     StandardOutput = "journal";
    #     StandardError = "journal";
    #   };
    #   environment = {
    #     XDG_RUNTIME_DIR = "/run/user/$UID";
    #   };
    # };
  };
}
