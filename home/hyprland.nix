{pkgs, config, inputs, ...}:{
  imports = [
    ./wallust.nix
  ];
  home.packages = with pkgs; [
    eww
    swww
    wl-clipboard-rs
    (writeShellScriptBin "wallpaper" ''
      WALLPAPER="${config.home.homeDirectory}/Pictures/wallpapers/arch-bridge.png"
      if [ -f "$WALLPAPER" ]; then
        ${swww}/bin/swww img "$WALLPAPER"
        ${wallust}/bin/wallust run "$WALLPAPER"
        ${eww}/bin/eww reload
      else
        echo "Wallpaper not found: $WALLPAPER"
      fi
    '')
    (writeShellScriptBin "watch-wallust" ''
      ${inotify-tools}/bin/inotifywait -m ${config.home.homeDirectory}/.cache/wallust -e modify | while read; do
        ${eww}/bin/eww reload
      done
    '')
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    xwayland.enable = true;
    systemd.enable = true;
    plugins = [];
    settings = {
      monitor = ",preferred,auto,1";
      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];
      exec-once = [
        "${pkgs.uwsm}/bin/uwsm app -- ${pkgs.swww}/bin/swww-daemon"
        "${pkgs.uwsm}/bin/uwsm app -- ${pkgs.eww-wayland}/bin/eww daemon --no-daemonize"
        "${pkgs.uwsm}/bin/uwsm app -- ${pkgs.eww-wayland}/bin/eww open bar"
        "${pkgs.coreutils}/bin/sleep 2 && ${pkgs.writeShellScriptBin.wallpaper}/bin/wallpaper"
        "${pkgs.writeShellScriptBin.watch-wallust}/bin/watch-wallust &"
      ];
      input = {
        kb_layout = "gb";
        follow_mouse = 1;
        sensitivity = 0;
      };
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
      };
      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      master = {
        new_status = "master";
      };
      gestures = {
        workspace_swipe = true;
      };
      misc = {
        force_default_wallpaper = 0;
      };

      # Keybindings
      "$mod" = "SUPER";
      "$terminal" = "wezterm";
      "$fileExplorer" = "${pkgs.xfc}thunar";
      bind = [
        "$mod, return, exec, $terminal"
        "$mod, Q, killactive"
        "$mod, Delete, exit"
        "$mod, E, exec, $fileExplorer"
        "$mod, T, togglefloating"
        "$mod, space, exec, ${pkgs.rofi-wayland}/bin/rofi -show drun"
        "$mod, J, togglesplit"
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
      ];
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

    };
  };
}
