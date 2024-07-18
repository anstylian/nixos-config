# How to configure the system:

1. nix build .#nixosConfigurations.angelos.activationPackage
nixos-rebuild switch --flake .#laptop

<!-- 2. text with local VM -->
<!-- nixos-rebuild build-vm --flake .#laptop -->
<!-- ./result/bin/run-*-vm -->

1. To update a flake
`nix flake update`

1. VM
QEMU_NET_OPTS="hostfwd=tcp::2222-:22,hostfwd=tcp::8065-:8065"

# Node:
To create this configuration I was influenced from [Mic92](https://github.com/Mic92/dotfiles) and [Misterio77](https://github.com/Misterio77/nix-config/tree/main).

If you want to run an application that is using UI as root: xhost +SI:localuser:root
To remove root from accessing UI: xhost -SI:localuser:root 
