{ ... }:
{
# TODO: export TMUX_TMPDIR=/run/user/$(id -u)
  programs = {
    tmux = {
      enable = true;
    };
  };
}
