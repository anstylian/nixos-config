{ pkgs, ... }: {
  home.packages = with pkgs; [
    obsidian        # Time managment
    signal-desktop  # Messaging app
  ];
}
