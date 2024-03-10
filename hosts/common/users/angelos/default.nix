{ pkgs, config, ... }:
let ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  networking = {
    hostName = "nixos-laptop";
  };

  users.mutableUsers = true;
  users.users.angelos = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "video"
      "audio"
    ] ++ ifTheyExist [
      "network"
      "wireshark"
      "i2c"
      "mysql"
      "docker"
      "podman"
      "git"
      "libvirtd"
      "deluge"
    ];
    openssh.authorizedKeys.keys = [ (builtins.readFile ../../../../home/angelos/ssh.pub) ];

    packages = [ pkgs.home-manager ];
  };

  home-manager.users.angelos = import ../../../../home/angelos/laptop.nix;

  services.geoclue2.enable = true;
  security.pam.services = { swaylock = { }; };
}
