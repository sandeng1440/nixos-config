{pkgs, config, ...}:{
  home.packages = with pkgs; [wallust];
  home.file.".config/wallust/wallust.toml".text = ''
    backend = "wal"
    threshold = 10
    colors = 16
    cache_dir = "${config.home.homeDirectory}/.cache/wallust"
  '';
}
