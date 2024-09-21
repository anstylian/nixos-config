{ pkgs, lib, config, ... }:
let
  homeCfgs = config.home-manager.users;
  homePaths = lib.mapAttrsToList (n: v: "${v.home.path}/share") homeCfgs;
  extraDataPaths = lib.concatStringsSep ":" homePaths;
  vars = ''XDG_DATA_DIRS="$XDG_DATA_DIRS:${extraDataPaths}"'';

  sway-kiosk = command: "${pkgs.sway}/bin/sway --config ${pkgs.writeText "kiosk.config" ''
    output * bg #000000 solid_color
    exec "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK"
    xwayland disable
    input "type:touchpad" {
      tap enabled
    }
    exec '${vars} ${command} -l debug; ${pkgs.sway}/bin/swaymsg exit'
  ''}";

  angelosCfg = homeCfgs.angelos;
in
{
  users.extraUsers.greeter = {
    packages = [
      angelosCfg.gtk.theme.package
      angelosCfg.gtk.iconTheme.package
    ];
    # For caching and such
    home = "/tmp/greeter-home";
    createHome = true;
  };

  # systemPackages = with pkgs; [
  #   canta-theme
  # ];

  programs.regreet = {
    enable = true;
    iconTheme.package = pkgs.canta-theme;
    theme.package = pkgs.canta-theme;
    font.package = pkgs.roboto-mono;
    cursorTheme.name = "Canta";
    cursorTheme.package = pkgs.canta-theme;
    settings = {
      GTK = {
        application_prefer_dark_theme = true;
        # font_name = "Roboto";
        # icon_theme_name = "";
        theme_name = lib.mkForce "Canta";
      };
      background = {
        path = ../../../home/angelos/global/vector-forest-sunset-forest-sunset-forest-wallpaper-b3abc35d0d699b056fa6b247589b18a8.jpg;
        fit = "Cover";
      };
    };
  };

  services.greetd = {
    enable = true;
    settings.default_session.command = sway-kiosk (lib.getExe config.programs.regreet.package);
  };
}
