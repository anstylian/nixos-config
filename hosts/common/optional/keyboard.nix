{pkgs, ...} : {
  hardware.keyboard = {
    qmk.enable = true;
    zsa.enable = true;
  };

  environment.systemPackages = with pkgs; [
     via
     qmk
  ];

  services.udev.packages = with pkgs; [ via ];
}

