{ pkgs, config, ... }:
let ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  sops.secrets.angelos-password.neededForUsers = true;
  sops.secrets.root-password.neededForUsers = true;

  users.mutableUsers = false;
  users.users.angelos = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "video"
      "audio"
    ] ++ ifTheyExist [
      "networkmanager"
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
    hashedPasswordFile = config.sops.secrets.angelos-password.path;

    packages = [ pkgs.home-manager ];
  };


  users.users.root.hashedPasswordFile = config.sops.secrets.root-password.path;

  home-manager.users.angelos = import ../../../../home/angelos/laptop.nix;

  services.geoclue2.enable = true;
  security.pam.services = { swaylock = { }; };
}
