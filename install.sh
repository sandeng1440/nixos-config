#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash git gnumake nano

# Development switch
# read -rp "Install script is incomplete. Exit? [Y/n] " confirm
# if [ -z "$confirm" ]; then 
# 	exit
# fi
# if [[ $confirm == "y" || $confirm == "Y" ]]; then 
# 	exit
# fi
#

## Variables
username=$(whoami)
echo "Cloning nixos-config..."
git clone https://github.com/sandeng1440/nixos-config.git ~/nixos-config || echo "FATAL ERROR: Git closed" && exit
echo "Opening flake.nix with nano..."
sleep 2 && nano ~/nixos-config/flake.nix

## Flake installation
nixos-generate-config --show-hardware-config > ~/nixos-config/host/hardware.nix
echo "-----------------------------------"
echo "Rebuilding the nix flake..."
sudo nixos-rebuild switch --flake ~/nixos-config

## Hyde-cli installation
echo "Cloning Hyde-cli..."
git clone https://github.com/kRHYME7/Hyde-cli.git ~/Hyde-cli || echo "FATAL ERROR: Git closed" && exit
cd ~/Hyde-cli
make LOCAL=1

## Hyprdots installation
echo "-----------------------------------"
echo "Cloning hyprdots..."
git clone https://github.com/prasanthrangan/hyprdots.git --depth=1 ~/hyprdots || echo "FATAL ERROR: Git closed" && exit
cd ~/hyprdots/Scripts || echo "FATAL ERROR: Could not cd into ~/hyprdots/Scripts" && exit
sed -i '/continue\ 2/d' ~/hyprdots/Scripts/restore_cfg.sh

## Theme patcher
Hyde-install --dir ~/hyprdots --link
Hyde restore Config
echo "Patching themes..."
sleep 2
Hyde theme patch

