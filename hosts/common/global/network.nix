{lib, ...}:
{
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = true;

  networking.useDHCP = lib.mkDefault true;
}
