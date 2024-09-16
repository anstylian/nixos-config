{ pkgs, ... }:
let 
  tmux2k = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux2k";
    version = "main-2024-09-16";
    src = pkgs.fetchFromGitHub {
      owner = "2KAbhishek";
      repo = "tmux2k";
      rev = "74c6c25a28111345cb9af1fd85e4c0b84236b242";
      sha256 = "sha256-KWoZkob1anemfv2mNJoIzlgAYnzo4HN8cU+Szm7DfjI=";
    };
    patches = [ ./tmux2k.patch ];
  };
in
{
  programs = {
    tmux = {
      enable = true;
      shell = "${pkgs.fish}/bin/fish";
      terminal = "tmux-256color";
      historyLimit = 100000;
      clock24 = true;
      baseIndex = 1;
      escapeTime = 100;
      mouse = true;
      plugins = 
        [
          pkgs.tmuxPlugins.yank
          pkgs.tmuxPlugins.tmux-thumbs
          pkgs.tmuxPlugins.fuzzback
          # {
          #   plugin = dracula;
          #   extraConfig = ''
          #     # available plugins: battery, cpu-usage, git, gpu-usage, ram-usage, tmux-ram-usage, network, network-bandwidth, network-ping,
          #     # ssh-session, attached-clients, network-vpn, weather, time, mpc, spotify-tui, kubernetes-context, synchronize-panes
          #     set -g @dracula-plugins "git battery time"
          #
          #     set -g @dracula-show-battery true
          #     set -g @dracula-show-powerline true
          #     set -g @dracula-refresh-rate 10
          #     set -g @dracula-military-time true
          #
          #     # it can accept `hostname` (full hostname), `session`, `shortname` (short name), `smiley`, `window`, or any character.
          #     set -g @dracula-show-left-icon 
          #   '';
          # }
          # {
          #   plugin = better-mouse-mode;
          #   extraConfig = ''
          #     setw -g mouse on
          #   '';
          # }
          pkgs.tmuxPlugins.resurrect
          pkgs.tmuxPlugins.better-mouse-mode
          tmux2k
        ];
      extraConfig = ''
        set -g @tmux2k-theme 'monokai'
        set -g @tmux2k-right-plugins "git battery netowrk time"
        set -g @tmux2k-window-list-alignment 'left'
        set -g @tmux2k-refresh-rate 2
        set -g @tmux2k-military-time true

        bind-key '"' split-window -c "#{pane_current_path}"
        bind-key % split-window -h -c "#{pane_current_path}"

        # enable true color
        set -as terminal-overrides ",alacritty*:Tc"
      '';
    };
  };
}
