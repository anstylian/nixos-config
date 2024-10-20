{ lib
, pkgs
, config
, ...
}: let 
  langs = [
    "bash"
    "c"
    "c-sharp"
    "cpp"
    "css"
    "elm"
    "elisp"
    "go"
    "hcl"
    "haskell"
    "html"
    "janet-simple"
    "java"
    "javascript"
    "jsdoc"
    "json"
    "julia"
    "ocaml"
    "pgn"
    "php"
    "python"
    "ruby"
    "rust"
    "scala"
    "typescript"
    "yaml"
    "nix"
    "lua"
    "markdown-inline"
    "perl"
    "make"
    "toml"
    "solidity"
  ];
in {
  home.packages = with pkgs; [
    neovim

    nodejs # copilot
    vale
    terraform-ls
    pyright
    lua-language-server

    gopls
    golangci-lint
    bash-language-server
    taplo-lsp
    marksman
    rust-analyzer
    yaml-language-server
    nil
    shellcheck
    shfmt
    isort
    black
    ruff
    nixpkgs-fmt
    nixd
    terraform-ls
    clang-tools
    nodePackages.prettier
    stylua
    # based on https://github.com/ray-x/go.nvim#go-binaries-install-and-update
    go
    gofumpt
    gotools
    delve
    golines
    gomodifytags
    gotests
    iferr
    impl
    reftools
    ginkgo
    richgo
    govulncheck
    solc

    deno
    lazygit
    gcc
    harper
  ];

  xdg.dataHome = "${config.home.homeDirectory}/.data";
  xdg.dataFile."nvim/lib/libfzf.so".source = "${pkgs.vimPlugins.telescope-fzf-native-nvim}/build/libfzf.so";
  # xdg.dataFile."nvim/lazy/telescope-fzf-native.nvim/build/libfzf.so".source = "${pkgs.vimPlugins.telescope-fzf-native-nvim}/build/libfzf.so";

  xdg.configFile.nvim.recursive = true;
  # astro-configs is a clone of https://github.com/AstroNvim/template
  xdg.configFile.nvim.source = pkgs.runCommand "nvim" { } ''
    mkdir -p $out/parser

    ln -s ${./astro-configs}/* $out/
    ln -s ${./astro-configs}/.* $out/

    ${lib.concatMapStringsSep "\n" (name: ''
      ln -s ${pkgs.tree-sitter.builtGrammars."tree-sitter-${name}"}/parser $out/parser/${name}.so
    '') langs}
  '';

}
