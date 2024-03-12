{ pkgs, ... }: {
  imports = [
    ./firefox.nix
    ./font.nix
    ./gtk.nix
  ];

  home.packages = with pkgs; [
    feh             # Simple image viewer
    pavucontrol     # Volume control
    cinnamon.nemo-with-extensions
  ];
}
