{ pkgs, ... }:
{
  programs = {
    tmux = {
      enable = true;
      shell = "${pkgs.fish}/bin/fish";
      terminal = "tmux-256color";
      historyLimit = 100000;
      clock24 = true;
      baseIndex = 1;
      plugins = with pkgs.tmuxPlugins ;
        [
          sensible
          yank
          tmux-thumbs
          fuzzback
          {
            plugin = dracula;
            extraConfig = ''
              				      # available plugins: battery, cpu-usage, git, gpu-usage, ram-usage, tmux-ram-usage, network, network-bandwidth, network-ping,
              				      # ssh-session, attached-clients, network-vpn, weather, time, mpc, spotify-tui, kubernetes-context, synchronize-panes
              				      set -g @dracula-plugins "git battery time"

              				      set -g @dracula-show-battery true
              				      set -g @dracula-show-powerline true
              				      set -g @dracula-refresh-rate 10
              				      set -g @dracula-military-time true
              			      '';
          }
          {
            plugin = better-mouse-mode;
            extraConfig = ''
              setw -g mouse on
            '';
          }
        ];
      extraConfig = ''
      '';
    };
  };
}