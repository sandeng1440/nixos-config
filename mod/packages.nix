{pkgs, ...}:
let inherit (import ../variables.nix) gitEmail gitUsername;
in {
  environment.systemPackages = with pkgs; [
    tldr
    bun
    jq
    git
    wget
    yazi
    lutris
    wezterm
  ];

  programs = {
    git = {
      enable = true;
      config = {
        user.name = gitUsername;
        user.email = gitEmail;
      };
    };
    neovim.enable = true;
    zsh.enable = false;
    localsend = {
      enable = true;
      openFirewall = true;
    };
    firefox.enable = true;
    starship.enable = true;
    fish ={
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
        set -g fish_key_bindings fish_vi_key_bindings
      '';
    };
    bash = {
      interactiveShellInit = ''
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
      '';
    };
  }; 
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  programs.dconf = {
    enable = true;
    # profiles.user.databases = [
    #   {
    #     settings."org/gnome/desktop/interface" = {
    #       gtk-theme = "Adwaita";
    #       icon-theme = "Flat-Remix-Red-Darkest";
    #       font-name = "Noto Sans Medium 11";
    #       document-font-name = "Noto Sans Medium 11";
    #       monospace-font-name = "Noto Sans Mono Medium 11";
    #     };
    #   }
    # ];
  };
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
  };
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-media-tags-plugin
      thunar-vcs-plugin
      thunar-archive-plugin
      thunar-volman
    ];
  };
}
