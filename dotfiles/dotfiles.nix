{pkgs, config, ...}:
let
  sym = config.lib.file.mkOutOfStoreSymlink;
  dir = "${config.home.homeDirectory}/nixos-config/dotfiles";
in {
  # home.file.".foo".source = config.lib.file.mkOutOfStoreSymlink ./some-source-file;
  home.file = {
    ".config/niri".source = sym "${dir}/niri";
    # ".config/matugen".source = sym "${dir}/matugen";
    # ".config/kitty/kitty.conf".source = sym "${dir}/kitty.conf";
    # ".config/swaync".source = sym "${dir}/swaync";

    # waybar
    ".config/waybar".source = sym "${dir}/waybar";

    # rofi
    # ".config/rofi/config.rasi".source = sym "${dir}/rofi-config.rasi";
    # ".config/rofi/themes/material-you/material-you.rasi".source = sym "${dir}/rofi-themes-material-you.rasi";
  };

  # scripts
  home.packages = with pkgs; [
    (writeShellScriptBin "wallpaper-cycle" ''
      WALLPAPER_DIR="${config.home.homeDirectory}/wallpapers"
      HISTORY_FILE="${config.home.homeDirectory}/.cache/wallpaper-history"
      ${pkgs.coreutils}/bin/mkdir -p "${config.home.homeDirectory}/.cache"

      # Get list of all wallpapers
      mapfile -t WALLPAPERS < <(${pkgs.findutils}/bin/find "$WALLPAPER_DIR" -type f -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg")

      # Check if wallpaper directory is empty
      if [ ''${#WALLPAPERS[@]} -eq 0 ]; then
        echo "No wallpapers found in $WALLPAPER_DIR"
        exit 1
      fi

      # Create history file if it doesn't exist
      ${pkgs.coreutils}/bin/touch "$HISTORY_FILE"

      # Read used wallpapers into an array
      mapfile -t USED < "$HISTORY_FILE"

      # Filter out used wallpapers
      AVAILABLE=()
      for wallpaper in "''${WALLPAPERS[@]}"; do
        if ! [[ " ''${USED[*]} " =~ " ''${wallpaper} " ]]; then
          AVAILABLE+=("$wallpaper")
        fi
      done

      # If no available wallpapers, reset history
      if [ ''${#AVAILABLE[@]} -eq 0 ]; then
        > "$HISTORY_FILE"
        AVAILABLE=("''${WALLPAPERS[@]}")
      fi

      # Select a random wallpaper from available ones
      SELECTED="''${AVAILABLE[$RANDOM % ''${#AVAILABLE[@]}]}"

      # Set wallpaper, generate colors, and reload eww
      if [ -f "$SELECTED" ]; then
        ${pkgs.swww}/bin/swww img "''${SELECTED}" --transition-type="center" --transition-step=1 --transition-fps=60
        ${pkgs.matugen}/bin/matugen image "''${SELECTED}"
        ${pkgs.procps}/bin/pkill waybar
        ${pkgs.waybar}/bin/waybar > /dev/null 2>&1 &
        ${pkgs.procps}/bin/pkill swaync
        ${pkgs.swaynotificationcenter}/bin/swaync > /dev/null 2>&1 &
        echo "$SELECTED" >> "$HISTORY_FILE"
      else
        echo "Selected wallpaper not found: $SELECTED"
        exit 1
      fi
    '')
  ];
}
