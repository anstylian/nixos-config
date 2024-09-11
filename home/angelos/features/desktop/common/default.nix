{ pkgs, ... }: {
  imports = [
    ./firefox.nix
    ./font.nix
    ./gtk.nix
    ./discord.nix
    ./slack.nix
    ./galculator.nix
    ./vscode.nix
  ];

  home.packages = with pkgs; [
    feh             # Simple image viewer
    pavucontrol     # Volume control
    nemo-with-extensions
    chromium
    libreoffice
    drawing         # edit image files
    keymapp
    meld
    # zsa keyboards
  ];
}
