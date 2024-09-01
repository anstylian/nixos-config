{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    # package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      rust-lang.rust-analyzer
      yzhang.markdown-all-in-one
      ms-vsliveshare.vsliveshare
      ms-vscode.cpptools
      ms-vscode.cmake-tools
      vadimcn.vscode-lldb
      jnoortheen.nix-ide
    ]
    ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "leo-extension";
        publisher = "aleohq";
        version = "0.32.1";
        sha256 = "sha256-aY89FHGGAmymiDWBUWbOqyWVs3VEDDWnSBEHl/kOURQ=";
      }
    ];
  };
}
