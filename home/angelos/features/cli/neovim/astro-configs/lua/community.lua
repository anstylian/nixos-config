return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  branch = "main",
  -- example of imporing a plugin, comment out to use it or add your own
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity
  -- { import = "astrocommunity.completion.copilot-lua", enable = false },
  -- { import = "astrocommunity.completion.copilot-lua-cmp", enable = false },
  -- {
  --   "zbirenbaum/copilot.lua",
  --   opts = {
  --     filetypes = {
  --       gitcommit = true,
  --     },
  --   },
  --   enable = false
  -- },
  { import = "astrocommunity.project.project-nvim" },
  { import = "astrocommunity.pack.go" },
  {
    "ray-x/go.nvim",
    -- don't install go binaries with the plugin
    -- instead we install these with nix: https://github.com/ray-x/go.nvim#go-binaries-install-and-update
    build = "true",
  },
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.nix" },
  { import = "astrocommunity.pack.harper" },
  { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
  { import = "astrocommunity.editing-support.auto-save-nvim" },
  {
    "loctvl842/monokai-pro.nvim",
    config = function()
      require("monokai-pro").setup {
        filter = "machine", -- classic | octagon | pro | machine | ristretto | spectrum
      }
    end,
  },
  { import = "astrocommunity.motion.nvim-surround" },
}
