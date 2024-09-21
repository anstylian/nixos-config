{
  services.gammastep = {
    enable = true;
    provider = "manual";
    temperature = {
      day = 6000;
      night = 4600;
    };
    settings = {
      general.adjustment-method = "wayland";
    };
    latitude = 35.18;
    longitude = 33.38;
    tray = true;
  };
}
