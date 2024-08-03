cd || exit
if command -v git &> /dev/null; then
	git clone https://github.com/sandeng1440/nixos-config.git
fi
cd nixos-config || exit

