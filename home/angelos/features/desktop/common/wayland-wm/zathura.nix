{ config, ... }:
let inherit (config.colorscheme) colors;
in {
  programs.zathura = {
    enable = true;
    options = {
      # selection-clipboard = "clipboard";
      # font = "${config.fontProfiles.regular.family} 12";
      # recolor = true;
      # default-bg = "#${colors.base00}";
      # default-fg = "#${colors.base01}";
      # statusbar-bg = "#${colors.base02}";
      # statusbar-fg = "#${colors.base04}";
      # inputbar-bg = "#${colors.base00}";
      # inputbar-fg = "#${colors.base07}";
      # notification-bg = "#${colors.base00}";
      # notification-fg = "#${colors.base07}";
      # notification-error-bg = "#${colors.base00}";
      # notification-error-fg = "#${colors.base08}";
      # notification-warning-bg = "#${colors.base00}";
      # notification-warning-fg = "#${colors.base08}";
      # highlight-color = "#${colors.base0A}";
      # highlight-active-color = "#${colors.base09}";
      # completion-bg = "#${colors.base01}";
      # completion-fg = "#${colors.base05}";
      # completions-highlight-bg = "#${colors.base0D}";
      # completions-highlight-fg = "#${colors.base07}";
      # recolor-lightcolor = "#${colors.base00}";
      # recolor-darkcolor = "#${colors.base06}";
    };
  };
  /*

#define base00 #272822
#define base01 #383830
#define base02 #49483e
#define base03 #75715e
#define base04 #a59f85
#define base05 #f8f8f2
#define base06 #f5f4f1
#define base07 #f9f8f5
#define base08 #f92672
#define base09 #fd971f
#define base0A #f4bf75
#define base0B #a6e22e
#define base0C #a1efe4
#define base0D #66d9ef
#define base0E #ae81ff
#define base0F #cc6633

  */
}
