{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    gnupg
    yubico-pam
    yubioath-flutter
    age-plugin-yubikey
  ];

}
