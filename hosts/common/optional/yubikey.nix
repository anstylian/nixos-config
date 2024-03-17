{ pkgs, ... }: {

  # smart card support
  services.pcscd.enable = true;

  environment.systemPackages = with pkgs; [
    gnupg
    yubico-pam
    yubioath-flutter
    age-plugin-yubikey
  ];
}
