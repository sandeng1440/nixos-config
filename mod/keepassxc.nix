{pkgs, ...}:{
  services.passSecretService.enable = true;
  environment.systemPackages = with pkgs;[keepassxc];
}
