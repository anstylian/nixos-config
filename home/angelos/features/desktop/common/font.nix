{ pkgs, ... }: {
  fontProfiles = {
    enable = true;
    monospace = {
      name = "Hurmit Nerd Font";
      package = pkgs.nerdfonts.override { fonts = [ "Hermit" ]; };
    };
    regular = {
      name = "Hermit";
      package = pkgs.hermit;
    };
  };
}
