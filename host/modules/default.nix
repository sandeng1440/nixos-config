{
lib,
inputs,
system,
config,
pkgs,
options,

username,
fullname,
hostname,
stateVersion,
timezone,
locale,
gitUsername,
gitEmail,
...
}:
{
imports = [
  ./nix.nix
  ./boilerplate.nix
  ./bootloader.nix
  ./env-vars.nix
  ./packages.nix  
];
}
