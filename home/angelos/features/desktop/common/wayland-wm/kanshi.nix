{
  services.kanshi = {
    enable = true;
    settings = [
      {
        profile = {
          name = "undocked";
          outputs = [
            {
              criteria = "eDP-1";
              scale = 1.0;
              status = "enable";
            }
          ];
        };
      }
      {
        profile = {
          name = "docked";
          outputs = [
            {
              criteria = "LG Electronics LG HDR 4K 0x0007A3B9";
              position = "1920,0";
              mode = "3840x2160@60Hz";
            }
            {
              criteria = "eDP-1";
              position = "2900,2160";
              mode = "1920x1080@60Hz";
            }
          ];
        };
      }
    ];
  };
}
