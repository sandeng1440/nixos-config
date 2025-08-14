{pkgs,...}:{
  systemd.user.services = {
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
