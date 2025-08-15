{pkgs, ...}:{
  environment.systemPackages = with pkgs; [
    lua51Packages.lua
    lua-language-server
    luajitPackages.luarocks-nix
    vimPlugins.nvim-treesitter.withAllGrammars
    gnutar gzip curl wget gcc
    lua imagemagick git fd ripgrep nodejs_24 gnumake unzip
    lazygit
    cargo rustc
    go python3Full
  ];
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withNodeJs = true;
    vimAlias = true;
    viAlias = true;
  };
}
