# NixOS Flake for Hyprdots
This flake has been made specifically to try and bring [Hyprdots](https://github.com/prasanthrangan/hyprdots) to NixOS. So far, I have successfully setup hyprdots from the git repo without making big modifications to the hyprdots repo. The most significant modification made is to the `~/.config/hypr/keybindings.conf` so that waybar plays nice. I'll write a bash script to install the dots soon. For now, I'm still working on the flake.

# Installation
## Flake
Change the user variables i.e **username, hostname, etc** inside the `flake.nix` file.
While inside the clone directory, copy the `hosts/void` to `hosts/<your hostname>`.
and generate the hardware configuration file.
```
cp -r hosts/void hosts/<your hostname>
nixos-generate-config --show-harware-config > hosts/<your hostname>/hardware.nix
```

# !!!!! IMPORTANT !!!!!
## THE FOLLOWING WILL DELETE SOME OF YOUR FILES. 
# !!!!! IMPORTANT !!!!!

## Hyprdots
Clone the [Hyprdots](https://github.com/prasanthrangan/hyprdots).
```
git clone --depth=1 https://github.com/prasanthrangan/hyprdots.git
cd hyprdots/Scripts
```
Run the `restore_cfg.sh`.
```
./restore_cfg.sh
```
Run the themepatcher for the themes you want. (Check the `themepatcher.lst` for the available themes)
```
./themepatcher "<Your Theme>" "<url to the theme>"
```
