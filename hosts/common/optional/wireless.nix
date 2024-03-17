{ config, ... }: {
  # Wireless secrets stored through sops
  sops.secrets.wireless-env-file = {
    neededForUsers = true;
    sopsFile = ../../../secrets/wifi.yaml;
  };

  networking.wireless = {
    enable = true;
    fallbackToWPA2 = false;
    # Declarative
    environmentFile = config.sops.secrets.wireless-env-file.path;
    networks = {
      "CYTA_tCes_5G" = {
        psk = "@CYTA_tCes_5G@";
      };
      "CYTA_90D8" = {
        psk = "@CYTA_90D8@";
      };
      "CYTA_pHj6" = {
        psk = "@CYTA_pHj6@";
      };
    };

    # Imperative
    allowAuxiliaryImperativeNetworks = true;
    userControlled = {
      enable = true;
      group = "network";
    };
    extraConfig = ''
      update_config=1
    '';
  };

  # Ensure group exists
  users.groups.network = { };

  systemd.services.wpa_supplicant.preStart = "touch /etc/wpa_supplicant.conf";
}
