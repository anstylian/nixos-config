{ pkgs, ... }: {
  imports = [
    ./bash.nix
    ./direnv.nix
    ./github-cli.nix
    ./git.nix
    # ./gpg.nix
    # ./nix-index.nix
    ./pfetch.nix
    # ./shellcolor.nix
    ./ssh.nix
    ./starship.nix
    ./neovim
    ./tmux
  ];

  home.packages = with pkgs; [
    comma             # Install and run programs by sticking a , before them
    distrobox         # Nice escape hatch, integrates docker images with my environment

    bc                # Calculator
    bottom            # System viewer
    ncdu              # TUI disk usage
    jq                # JSON pretty printer and manipulator
    btop              # Resource Manager
    nitch             # Minimal fetch
    ranger            # File Manager
    tldr              # Helper
    unzip             # Zip files
    zip               # Zip files
    lm_sensors        # Computer temperature sensors
    ntfs3g            # mount ntfs filesystem

    eza               # Better ls
    ripgrep           # Better grep
    fd                # Better find
    httpie            # Better curl
    diffsitter        # Better diff
    bat               # Better cat
    tre-command       # Better tree
    dutree            # Better du
    tldr              # Better man

    man-pages         # man-pages

    nil               # Nix LSP
    nixfmt            # Nix formatter

    ltex-ls           # Spell checking LSP

    ssh-to-age        # Convert ssh private keys in ed25519 format to age keys
    keyutils          # Tools used to control the Linux kernel key management system

    cloc              # Count Lines of Code
  ];
}
