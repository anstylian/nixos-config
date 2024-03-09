{ inputs, ... }:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops.defaultSopsFile = ../../../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "/home/angelos/.config/sops/age/keys.txt";
  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

  # sops.secrets = {
  #   "angelos-password" = { };
  #   "example-key" = { };
  #   "myservice/my_subdir/my_secret" = { };
  #   # "guest_accounts.json" = { };
  #   # "npmrc" = {
  #   #   owner = "youruser";
  #   #   path = "/home/youruser/.npmrc";
  #   #     };
  #   };
  }
