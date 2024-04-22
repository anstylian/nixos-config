{ pkgs, ... }: {
  imports = [
    ./firefox.nix
    ./font.nix
    ./gtk.nix
    ./discord.nix
    ./slack.nix
  ];

  home.packages = with pkgs; [
    feh             # Simple image viewer
    pavucontrol     # Volume control
    cinnamon.nemo-with-extensions
    chromium
    libreoffice
    drawing         # edit image files
    vscode
  ];
}
