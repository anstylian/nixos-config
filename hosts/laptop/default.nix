{ pkgs, inputs, modulesPath, ... }: {
  imports = [
    # "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    inputs.nixos-hardware.nixosModules.dell-precision-3541
    ./hardware-configuration.nix

    ../common/global
    ../common/users/angelos

    ../common/optional/powertop.nix
    ../common/optional/wireless.nix
    ../common/optional/greetd.nix
    ../common/optional/pipewire.nix
    ../common/optional/yubikey.nix
  ];

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    configPackages = [
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  powerManagement.powertop.enable = true;
  programs = {
    light.enable = true;
    dconf.enable = true;
  };

  # Lid settings
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
  };

  # hardware = {
  #   /*
  #     nvidia = {
  #     prime = {
  #       offload.enable = true;
  #       nvidiaBusId = "PCI:1:0:0";
  #       intelBusId = "PCI:0:2:0";
  #     };
  #     };
  #   */
  #   opengl = {
  #     enable = true;
  #     driSupport = true;
  #     driSupport32Bit = true;
  #   };
  # };

  # TODO adapte this one
  services.xserver = {
    enable = true;
    # Configure keymap in X11
    xkb = {
      layout = "us, gr";
      options = "grp:alt_shift_toggle";
    };
    # Enable touchpad support (enabled default in most desktopManager).
    libinput = {
      enable = true;
      # touchpad = {
      #   tapping = true;
      #   clickMethod = "clickfinger";
      # };
    };
    # synaptics = {
    #   enable = true;
    # };
    displayManager.lightdm.enable = false; # LightDM is enable by default so we disapling it here
  };

  services.udisks2.enable = true;

  networking.firewall.enable = true;
  system.stateVersion = "23.11";
}
