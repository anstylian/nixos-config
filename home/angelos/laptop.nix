{ inputs, ... }:
let
  # dark-mode = true;
  # inherit (inputs.nix-colors.colorSchemes) silk-dark silk-light;
  inherit (inputs.nix-colors.colorSchemes) monokai;
in
{
  imports = [
    ./global
    ./features/desktop/wireless
    ./features/desktop/sway
    ./features/desktop/optional
    ./features/desktop/optional/udiskie.nix
    # ./features/pass
  ];

  wallpaper = ./global/vector-forest-sunset-forest-sunset-forest-wallpaper-b3abc35d0d699b056fa6b247589b18a8.jpg;
  # colorscheme = if dark-mode then silk-dark else silk-light;
  colorscheme = monokai;
  # colorscheme = silk-dark;
  # sessionVariables = { TERMINAL = "tmux-256color"; };

  monitors = [
    {
      name = "eDP-1";
      width = 1920;
      height = 1080;
      workspace = "3";
      x = 0;
      y = 0;
      refreshRate = 60;
    }
    {
      name = "DP-2";
      width = 1920;
      height = 1080;
      workspace = "1";
      x = 1920;
      y = 0;
      refreshRate = 60;
    }
  ];
}
