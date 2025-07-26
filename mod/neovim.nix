{pkgs, ...}:{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withNodeJs = true;
    vimAlias = true;
    viAlias = true;
    package = pkgs.neovim-unwrapped;
    # plugins = with pkgs; [
    #   vimPlugins.LazyVim vimPlugins.nvim-treesitter
    # ];
    # extraLuaPackages = ps: [ ps.magick ];
    # extraPackages = with pkgs; [
    #   gnutar gzip curl wget
    #   lua imagemagick git fd ripgrep gcc nodejs_24 gnumake unzip
    #   lazygit lazygit
    #   rustup cargo
    #   go python3Full
    # ];
  };
  environment.systemPackages = with pkgs; [
    luajitPackages.luarocks-nix
    vimPlugins.nvim-treesitter.withAllGrammars
    gnutar gzip curl wget gcc
    lua imagemagick git fd ripgrep gcc nodejs_24 gnumake unzip
    lazygit lazygit
    rustup cargo
    go python3Full
  ];
}
