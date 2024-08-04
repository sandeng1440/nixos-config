# Development switch
read -rp "Install script is incomplete. Exit? [Y/n] " confirm
if [ -z "$confirm" ]; then 
	exit
fi
if [[ $confirm == "y" || $confirm == "Y" ]]; then 
	exit
fi
#

## Variables
set -e
username=$(whoami)
read -rp "Choose your text editor [ vim ]" editor
if [ -z "$editor" ]; then
	editor="vim"
fi
if $editor flake.nix; then

## Flake installation
cd || exit
if command -v git &> /dev/null; then
	git clone https://github.com/sandeng1440/nixos-config.git
fi
cd nixos-config || exit

## Hyde-cli installation

## Hyprdots installation

## Theme patcher
