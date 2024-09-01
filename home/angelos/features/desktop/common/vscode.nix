{ pkgs }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      rust-lang.rust-analyzer 
      yzhang.markdown-all-in-one
      ms-vsliveshare.vsliveshare
      ms-vscode.cpptools
      ms-vscode.cmake-tools
      b4dm4n.vscode-nixpkgs-fmt
      vadimcn.vscode-lldb
    ];
  };
}
