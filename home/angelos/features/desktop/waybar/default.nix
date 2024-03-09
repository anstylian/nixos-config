{ config, lib, pkgs, host, user, ...}:

{
  nixpkgs.overlays = [                                      # Waybar needs to be compiled with the experimental flag for wlr/workspaces to work (for now done with hyprland.nix)
     (self: super: {
       waybar = super.waybar.overrideAttrs (oldAttrs: {
         mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
         patchPhase = ''
           substituteInPlace src/modules/wlr/workspace_manager.cpp --replace "zext_workspace_handle_v1_activate(workspace_handle_);" "const std::string command = \"hyprctl dispatch workspace \" + name_; system(command.c_str());"
         '';
       });
     })
   ];
    programs.waybar = {
      enable = true;
      systemd ={
        enable = true;
        target = "sway-session.target";                     # Needed for waybar to start automatically
      };

      style = ''
/* =============================================================================
 *
 * Waybar styles
 *
 * Styles reference: https://github.com/Alexays/Waybar/wiki/Configuration
 *
 * =========================================================================== */

/* -----------------------------------------------------------------------------
 * Keyframes
 * -------------------------------------------------------------------------- */

@keyframes blink-warning {
    70% {
        color: white;
    }

    to {
        color: white;
        background-color: orange;
    }
}

@keyframes blink-critical {
    70% {
      color: white;
    }

    to {
        color: white;
        background-color: red;
    }
}


/* -----------------------------------------------------------------------------
 * Base styles
 * -------------------------------------------------------------------------- */

/* Reset all styles */
* {
    border: none;
    border-radius: 0;
    min-height: 0;
    margin: 0;
    padding: 0;
}

/* The whole bar */
#waybar {
    background-color: #222222; /* Sway palette: unfocused/background */
    color: #ffffff; /* Sway palette: focused/text */
    font-family: system-ui, sans-serif;
    font-size: 14px;
}

/* -----------------------------------------------------------------------------
 * Module styles
 * -------------------------------------------------------------------------- */

/* Each module */
#backlight,
#battery,
#clock,
#cpu,
#custom-keyboard-layout,
#idle_inhibitor,
#memory,
#mode,
#network,
#pulseaudio,
#temperature,
#tray {
    margin-left: 18px;
}

#backlight {
    /* No styles */
}

#battery {
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
}

#battery.warning {
    color: orange;
}

#battery.critical {
    color: red;
}

#battery.warning.discharging {
    animation-name: blink-warning;
    animation-duration: 3s;
}

#battery.critical.discharging {
    animation-name: blink-critical;
    animation-duration: 2s;
}

#clock {
    /* No styles */
}

#clock.time {
    margin-left: 12px;
    margin-right: 12px;
    min-width: 60px;
}

#cpu {
  /* No styles */
}

#cpu.warning {
    color: orange;
}

#cpu.critical {
    color: red;
}

#custom-keyboard-layout {
    margin-left: 22px;
}

#memory {
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
}

#memory.warning {
    color: orange;
}

#memory.critical {
    color: red;
    animation-name: blink-critical;
    animation-duration: 2s;
}

#mode {
    color: #ffffff; /* Sway palette: urgent/text */
    background-color: #900000; /* Sway palette: urgent/background */
    margin-left: 0;
    /* To compensate for the top border and still have vertical centering */
    padding: 0 16px;
}

#network {
    /* No styles */
}

#network.disconnected {
    color: orange;
}

#pulseaudio {
    /* No styles */
}

#pulseaudio.muted {
    /* No styles */
}

#temperature {
    /* No styles */
}

#temperature.critical {
    color: red;
}

#tray {
    /* No styles */
}

#window {
    margin-left: 32px;
    margin-right: 32px;
}

#workspaces button {
    border-top: 2px solid transparent;
    /* To compensate for the top border and still have vertical centering */
    padding-bottom: 2px;
    padding-left: 15px;
    padding-right: 18px;
    color: #888888; /* Sway palette: unfocused/text */
}

#workspaces button:hover {
    /* Reset all hover styles */
    background: inherit;
    box-shadow: inherit;
    text-shadow: inherit;
}

#workspaces button.visible {
    border-color: #333333; /* Sway palette focused_inactive/border */
    color: #ffffff; /* Sway palette: focused_inactive/text */
    background-color: #5f676a; /* Sway palette focused_inactive/background */
}

#workspaces button.focused {
    border-color: #4c7899; /* Sway palette: focused/border */
    color: #ffffff; /* Sway palette: focused/text */
    background-color: #285577; /* Sway palette: focused/background */
}

#workspaces button.urgent {
    border-color: #2f343a;  /* Sway palette: urgent/border */
    color: #ffffff; /* Sway palette: urgent/text */
    background-color: #900000; /* Sway palette: urgent/background */
}

#custom-menu {
    color: #96AFF8;  /* #A7C7E7; */
}
      '';
      settings = {
        Main = {
            "layer" = "bottom";

            "position" = "top";

            # If height property would be not present, it'd be calculated dynamically
            "height" = 32;

            "modules-left" = [
                "custom/menu"
                "sway/workspaces"
                "sway/mode"
            ];
            "modules-center" = [
                "sway/window"
            ];
            "modules-right" = [
                "network"
                "idle_inhibitor"
                "memory"
                "cpu"
                "temperature"
                "custom/keyboard-layout"
                "backlight"
                "pulseaudio"
                "battery"
                "tray"
                "clock#date"
                "clock#time"
            ];

            # ***************************
            # *  MODULES CONFIGURATION  *
            # ***************************

            "sway/workspaces" = {
                "all-outputs" = false;
                "disable-scroll" = true;
                "format" = "{icon} {name}";
                "format-icons" = {
                    "1:terminal" = " ";
                    "2:www" = "";
                    "3:reading" = "🕮 ";
                    "4:coding" = "⌨ ";
                    "default" = "";
                    "urgent" = " ";
                };
            };

            "custom/keyboard-layout" = {
                "exec" = "${pkgs.sway}/bin/swaymsg -t get_inputs | ${pkgs.gnugrep}/bin/grep -m1 'xkb_active_layout_name' | ${pkgs.coreutils}/bin/cut -d '\"' -f4 | ${pkgs.coreutils}/bin/cut -d ' ' -f1";
                # Interval set only as a fallback, as the value is updated by signal
                "interval" = 10;
                "format" = " {}"; # Icon: keyboard
                # Signal sent by Sway key binding (~/.config/sway/key-bindings)
                "signal" = 1; # SIGHUP
                "tooltip" = false;
                "on-click" = "${pkgs.sway}/bin/swaymsg input type:keyboard xkb_switch_layout next";
                "on-scroll-up" = "${pkgs.sway}/bin/swaymsg input type:keyboard xkb_switch_layout next";
                "on-scroll-down" = "${pkgs.sway}/bin/swaymsg input type:keyboard xkb_switch_layout prev";
            };

            "backlight" = {
                "format" = " {percent}%";
                "interval" = 2;
                "on-scroll-up" = "brightnessctl set +2%";
                "on-scroll-down" = "brightnessctl set 2%-";
            };

            "battery" = {
                "interval" = 10;
                "states" = {
                    "warning" = 25;
                    "critical" = 1;
                };
                # Connected to AC
                "format" = " {icon} {capacity}%"; # Icon: bolt
                # Not connected to AC
                "format-discharging" = "{icon} {capacity}%";
                "format-icons" = [
                    " "            # Icon = battery-full
                    " "            # Icon = battery-three-quarters
                    " "            # Icon = battery-half
                    " "            # Icon = battery-quarter
                    " "            # Icon = battery-empty
                ];
                "tooltip" = true;
            };

            "clock#time" = {
                "interval" = 1;
                "format" = "{:%H:%M:%S}";
                "tooltip" = false;
            };

            "clock#date" = {
                "interval" = 10;
                "format" = " {:%e %b %Y}";         # Icon: calendar-alt
                "tooltip-format" = "{:%e %B %Y}";
                "locale" = "en_US.UTF-8";
                "timezone" = "Europe/Warsaw";
            };

            "cpu" = {
                "interval" = 3;
                "format" = " {usage}% ({load})";   # Icon: microchip
                "states" = {
                  "warning" = 70;
                  "critical" = 90;
                };
            };

            "idle_inhibitor" = {
                "format" = "{icon}";
                "format-icons" = {
                    "activated" = "";
                    "deactivated" = "";
                };
            };

            "memory" = {
                "interval" = 3;
                "format" = "  {}%";     # Icon: memory
                "states" = {
                    "warning" = 70;
                    "critical" = 90;
                };
            };

            "network" = {
                "interval" = 3;
                "format-wifi" = "  {essid}"; # Icon: wifi
                "format-ethernet" = "  {ifname}: {ipaddr}/{cidr}"; # Icon: ethernet
                "format-disconnected" = "⚠  Disconnected";
                "tooltip-format" = "{ifname}: {ipaddr} (signal: {signalStrength}%)";
            };

            "pulseaudio" = {
                "scroll-step" = 2;
                "format" = "{icon} {volume}%";
                "format-muted" = " Muted"; # Icon: volume-mute
                "format-icons" = {
                    "headphones" = " ";     # Icon: headphones
                    "handsfree" = " ";      # Icon: headset
                    "headset" = " ";        # Icon: headset
                    "phone" = "";          # Icon: phone
                    "portable" = "";       # Icon: phone
                    "car" = " ";            # Icon: car
                    "default" = ["" "" ];  # Icons: volume-down, volume-up
                };
                "on-click" = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
                "on-click-right" = "alacritty --title='Sound Mixer' --command='pulsemixer'";
                "tooltip" = true;
            };

            "sway/mode" = {
                "format" = "<span style=\"italic\"> {}</span>";  # Icon: expand-arrows-alt
                "tooltip" = false;
            };

            "sway/window" = {
                "format" = "{}";
                "max-length" = 120;
            };

            "temperature" = {
              "critical-threshold" = 75;
              "interval" = 3;
              "format" = "{icon} {temperatureC}°C";
              "format-icons" = [
                  "" 
                  "" 
                  "" 
                  "" 
                  "" 
              ];
              "tooltip" = true;
            };

            "tray" = {
                "icon-size" = 21;
                "spacing" = 10;
            };

            "custom/menu" = {
                format = "<span font='16'> </span>";
                #on-click = "${pkgs.rofi}/bin/rofi -show p -modi p:${pkgs.rofi-power-menu}/bin/rofi-power-menu -theme $HOME/.config/rofi/config.rasi";
                #on-click-right = "${pkgs.rofi}/bin/rofi -show drun";
                on-click = ''~/.config/wofi/power.sh'';
                on-click-right = "${pkgs.wofi}/bin/wofi --show drun";
                tooltip = false;
            };
        };
      };
    };
    home.file = {
      ".config/waybar/script/sink.sh" = {              # Custom script: Toggle speaker/headset
        text = ''
          #!/bin/sh

          HEAD=$(awk '/ Built-in Audio Analog Stereo/ { print $2 }' <(${pkgs.wireplumber}/bin/wpctl status | ${pkgs.gnugrep}/bin/grep "*") | ${pkgs.gnused}/bin/sed -n 2p)
          SPEAK=$(awk '/ S10 Bluetooth Speaker/ { print $2 }' <(${pkgs.wireplumber}/bin/wpctl status | ${pkgs.gnugrep}/bin/grep "*") | head -n 1)

          if [[ $HEAD = "*" ]]; then
            printf "<span font='13'></span>\n"
          elif [[ $SPEAK = "*" ]]; then
            printf "<span font='10'>蓼</span>\n"
          fi
          exit 0
        '';
        executable = true;
      };
      ".config/waybar/script/switch.sh" = {              # Custom script: Toggle speaker/headset
        text = ''
          #!/bin/sh

          ID1=$(awk '/ Built-in Audio Analog Stereo/ {sub(/.$/,"",$2); print $2 }' <(${pkgs.wireplumber}/bin/wpctl status) | head -n 1)
          ID2=$(awk '/ S10 Bluetooth Speaker/ {sub(/.$/,"",$2); print $2 }' <(${pkgs.wireplumber}/bin/wpctl status) | ${pkgs.gnused}/bin/sed -n 2p)

          HEAD=$(awk '/ Built-in Audio Analog Stereo/ { print $2 }' <(${pkgs.wireplumber}/bin/wpctl status | ${pkgs.gnugrep}/bin/grep "*") | ${pkgs.gnused}/bin/sed -n 2p)
          SPEAK=$(awk '/ S10 Bluetooth Speaker/ { print $2 }' <(${pkgs.wireplumber}/bin/wpctl status | ${pkgs.gnugrep}/bin/grep "*") | head -n 1)

          if [[ $HEAD = "*" ]]; then
            ${pkgs.wireplumber}/bin/wpctl set-default $ID2
          elif [[ $SPEAK = "*" ]]; then
            ${pkgs.wireplumber}/bin/wpctl set-default $ID1
          fi
          exit 0
        '';
        executable = true;
      };
    };
}
