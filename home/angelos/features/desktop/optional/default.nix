{ pkgs, ... }: {
  home.packages = with pkgs; [
    obsidian        # Time managment
    signal-desktop  # Messaging app
    d-spy           # Monitor dbus
  ];
}
