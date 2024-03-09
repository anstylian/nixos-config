{ inputs, pkgs, config, lib, outputs, ... }:
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
    # hashedPasswordFile = config.sops.secrets.angelos-password.path;
    # password = "123";

    packages = [ pkgs.home-manager ];
  };

  # sops.secrets.angelos-password = {
  #   sopsFile = ../../../../secrets/secrets.yaml;
  #   neededForUsers = true;
  # };

  # users.users.root.password = "123"; # this is only for testing

  home-manager.users.angelos = import ../../../../home/angelos/laptop.nix;

  services.geoclue2.enable = true;
  security.pam.services = { swaylock = { }; };

  sops.secrets."angelos-password" = { };
  sops.secrets.example-key = { };
  sops.secrets."myservice/my_subdir/my_secret" = {
    owner = "sometestservice";
  };

  systemd.services."sometestservice" = {
    script = ''
        echo "
        Hey bro! I'm a service, and imma send this secure password:
        $(cat ${config.sops.secrets."myservice/my_subdir/my_secret".path})
        located in:
        ${config.sops.secrets."myservice/my_subdir/my_secret".path}
        to database and hack the mainframe
        " > /var/lib/sometestservice/testfile
      '';
    serviceConfig = {
      User = "sometestservice";
      WorkingDirectory = "/var/lib/sometestservice";
    };
  };

  users.users.sometestservice = {
    home = "/var/lib/sometestservice";
    createHome = true;
    isSystemUser = true;
    group = "sometestservice";
  };
  users.groups.sometestservice = { };

}
