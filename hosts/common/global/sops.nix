{ inputs, pkgs, ... }:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  environment = {
    systemPackages = with pkgs; [
      sops
    ];
  };

  sops.defaultSopsFile = ../../../secrets/users/angelos.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/root/.config/sops/age/keys.txt";
  # sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
}
