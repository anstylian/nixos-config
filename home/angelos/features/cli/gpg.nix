{ pkgs, ... }:
let
  pinentry =
    {
      packages = [ pkgs.pinentry-curses ];
      name = "tty";
    };

  # public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDLMo6eI9uLEWG9m3GuKbxPq46uvoaBdu4Rtt+8rb/zdS6y0a0oRjrV2LBANtFEYed98jduHm6jqy700/24r/iF/KU2wrulOaBPqbqYRAlgacgoTaGhQ4Bm2PAZ3dsBv/3xt44Z54706vTRFJJg6b6dklrLLUCqPky2XFczMlXxpDBr+ph7nyiOmVOkkphNiCeYcaLmhzcuojKiR8flivW0uj+II6ZnZVuDBESvizkmYfxEs2Ons1ewsoWX4teOotcQhy9UOpWP9cTqQ1i5xiwYMSt2kkrSyFSnGlOiBi7r1yY2lwAGWnjANXysY6n+rPORIBmIXj5XOGSOhwLs0VBvIl0+diHBXEMtpZsMnK6hRSyJKEiwkXgpe/E2R2Uud9MWzcid+vShBMS5A28EA1vDLbGyiMMVR49nw6054xgbRyuX67GaXLfJlqDnoK8pvNxdgw44VhNjUv7o6/eETv3DfoKXuU+BpP1qFvYM/+ZWLruLwjVxAZJeo7aR8Vh1hl8= angelos@nixos";
in
{
  home.packages = pinentry.packages;

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    # sshKeys = [ public_key ]; TODO
    pinentryFlavor = pinentry.name;
    enableExtraSocket = true;
  };

  programs =
    let
      fixGpg = ''
        gpgconf --launch gpg-agent
      '';
    in
    {
      # Start gpg-agent if it's not running or tunneled in
      # SSH does not start it automatically, so this is needed to avoid having to use a gpg command at startup
      # https://www.gnupg.org/faq/whats-new-in-2.1.html#autostart
      bash.profileExtra = fixGpg;
      fish.loginShellInit = fixGpg;
      zsh.loginExtra = fixGpg;

      gpg = {
        enable = true;
      # TODO
      #   settings = {
      #     trust-model = "tofu+pgp";
      #   };
      #   publicKeys = [{
      #     source = ../../pgp.asc;
      #     trust = 5;
      #   }];
      };
    };

  systemd.user.services = {
    # Link /run/user/$UID/gnupg to ~/.gnupg-sockets
    # So that SSH config does not have to know the UID
    link-gnupg-sockets = {
      Unit = {
        Description = "link gnupg sockets from /run to /home";
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.coreutils}/bin/ln -Tfs /run/user/%U/gnupg %h/.gnupg-sockets";
        ExecStop = "${pkgs.coreutils}/bin/rm $HOME/.gnupg-sockets";
        RemainAfterExit = true;
      };
      Install.WantedBy = [ "default.target" ];
    };
  };
}
# vim: filetype=nix
