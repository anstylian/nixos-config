
{ pkgs, ... }: {
  home.packages = with pkgs; [
    galculator
    gdk-pixbuf
  ];
}
