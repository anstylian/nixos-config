{ pkgs, ... }: {
  imports = [
    # ./discord.nix
    # ./dragon.nix
    ./firefox.nix
    ./font.nix
    ./gtk.nix
    # ./slack.nix
    # ./sublime-music.nix
  ];

  home.packages = with pkgs; [
    feh             # Simple image viewer
    pavucontrol     # Volume control
    # obsidian        # Time managment
    signal-desktop  # Messaging app
  ];
}
