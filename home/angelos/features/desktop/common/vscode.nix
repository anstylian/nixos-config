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
      mkhl.direnv
      vadimcn.vscode-lldb
      dbaeumer.vscode-eslint
    ]
    ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "leo-extension";
        publisher = "aleohq";
        version = "0.32.1";
        sha256 = "sha256-aY89FHGGAmymiDWBUWbOqyWVs3VEDDWnSBEHl/kOURQ=";
      }
      {
        name = "esbuild-problem-matchers";
        publisher = "connor4312";
        version = "0.0.3";
        sha256 = "sha256-esLqld9bTlFJ9/qx4qlIx1F3MtMZpr8G9/FMqGvAvtg=";
      }
      {
        name = "mock-debug";
        publisher = "ms-vscode";
        version = "0.52.0";
        sha256 = "sha256-l+00y6xJt7vAS8kv6PjBMwUJCNG1ZgFsMQoGXlC6J88=";
      }
    ];
  };
}
