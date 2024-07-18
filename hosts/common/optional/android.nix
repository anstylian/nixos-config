{pkgs, ...}:
{
  environment.systemPackages = [
    pkgs.android-tools
    pkgs.android-studio
  ];

  programs = {
    adb = {
      enable = true;
    };
  };

  services.udev.packages = [
    pkgs.android-udev-rules
  ];
}
