# NixOS Flake for Hyprdots
This flake has been made specifically to try and bring [Hyprdots](https://github.com/prasanthrangan/hyprdots) to NixOS. To make it work, I had to abandon some reproducible parts of the nix flake such as the gtk theme. 

So far, I have successfully setup hyprdots from the git repo without making big modifications to the hyprdots repo. The most significant modification made is to the `~/.config/hypr/keybindings.conf` so that waybar plays nice. I'll write a bash script to install the dots soon. For now, I'm still working on the flake.

### Screenshots
<details>
<summary><b>Screenshot 1</b></summary>

 ![Screenshot1](https://github.com/user-attachments/assets/c08cbd70-79d8-4793-a37d-b1452dbadead)
</details>
<details>
<summary><b>Screenshot 2</b></summary>
 
 ![Screenshot2](https://github.com/user-attachments/assets/a2a4af8e-dd90-40c4-b187-b8dedbf971bb)
</details>
<details>
<summary><b>Screenshot 3</b></summary>
 
 ![Screenshot3](https://github.com/user-attachments/assets/972bd91d-8fdc-4b72-a905-5893603cf09c)
</details>

# Installation
## Flake
Clone the repo.
```
git clone --depth=1 https://github.com/sandeng1440/nixos-config ~/nixos-config
cd nixos-config
```

Change the user variables i.e **username, hostname, etc** inside the `flake.nix` file.
```
nvim flake.nix
```
While inside the clone directory,
generate the hardware configuration file.
```
nixos-generate-config --show-hardware-config > host/hardware.nix
```
Then rebuild the system. (Replace `<hostname>` with your hostname)
```
NIX_CONFIG="experimental-features = nix-command flakes" 
sudo nixos-rebuild switch --flake .#<hostname>
```

Rebuild the home-manager configuration. For this command to succeed, delete `~/.icons/`,`~/.gtkrc-2.0`,
`~/.config/gtk-3.0/`, `~/.config/gtk-4.0/`

```
nix run home-manager/master --accept-flake-config -- switch --flake .
```


> [!IMPORTANT]
> THE FOLLOWING WILL DELETE SOME OF YOUR FILES. PROCEED WITH CAUTION. 

## Hyprdots installation through HyDE-cli
Clone the [HyDE-cli](https://github.com/kRHYME7/Hyde-cli) repo.
```
git clone --depth=1 https://github.com/kRHYME7/Hyde-cli.git ~/Hyde-cli
```
Cd into the repo and use `make` to install it.
```
cd ~/Hyde-cli
make LOCAL=1
```
Now that Hyde-cli is installed, you may use it to restore the configuration files.
First clone the [Hyprdots](https://github.com/prasanthrangan/hyprdots) repo in your home directory.
```
git clone --depth=1 https://github.com/prasanthrangan/hyprdots.git ~/hyprdots
```
Then link the directory to Hyde-cli.
```
Hyde-install --dir ~/hyprdots --no-package --link
```
It may fail but don't worry, the link has been established, which is the most important.
Now restore the configs using hyprdots then Hyde-cli.
```
sed -i '/continue 2/d' ~/hyprdots/Scripts/restore_cfg.sh
~/hyprdots/Scripts/restore_cfg.sh
Hyde restore Config
```
Then replace the `~/.config/hypr/keybindings.conf` with `~/nixos-config/setup/keybindings.conf`. This fixes the bug with waybar, where it is duplicated. The bug is because the name of the `waybar` process is `.waybar-wrapped`. (Execute `ps -a` to confirm)
```
cp -f ~/nixos-config/setup/keybindings.conf ~/.config/hypr/userprefs.conf
```
Now use Hyde-cli to patch themes.
```
Hyde theme patch
```
 
> [!NOTE]
> This command has failed a lot for me. If it fails on you, then patch the themes using this script `~/hyprdots/Scripts/themepatcher.sh`. The core hyprdots themes are listed in `~/hyprdots/Scripts/themepatcher.lst`.
> For example, to patch **Catppuccin Mocha** theme, execute:
> ```
> ~/hyprdots/Scripts/themepatcher.sh "Catppuccin Mocha" "https://github.com/prasanthrangan/hyde-themes/tree/Catppuccin-Mocha"
> ```
 
Now reboot and enjoy your Hyprdots.

## (Optional) Hyprdots manual installation 
Clone the [Hyprdots](https://github.com/prasanthrangan/hyprdots) repo.
```
git clone --depth=1 https://github.com/prasanthrangan/hyprdots.git ~/hyprdots
cd ~/hyprdots/Scripts
```
Run the `restore_cfg.sh`.
```
./restore_cfg.sh
```
Run the themepatcher for the themes you want. (Check the `themepatcher.lst` for the available themes)
```
./themepatcher "<Your Theme>" "<url to the theme>"
```

# TODO
- [X] Install sddm theme
- [ ] Write install script
- [ ] Make the flake generic
- [ ] Modularize the flake
- [ ] Integrate hyprdots with home-manager
- [ ] Debloat the flake
- [ ] Move to stable hyprland and stable nix pkgs
