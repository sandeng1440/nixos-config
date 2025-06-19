{pkgs, ...}:
let inherit (import ../variables.nix) username fullname;
in
{
  nix.settings.trusted-users = ["${username}"];
  environment.localBinInPath = true;
  users.users.${username} = {
    isNormalUser = true;
    description = "${fullname}";
    extraGroups = [ "lp" "video" "networkmanager" "wheel" ];
    packages = with pkgs; [
      neovim
    ];
  };
}
