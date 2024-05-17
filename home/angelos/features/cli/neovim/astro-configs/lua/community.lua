-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.note-taking.venn-nvim" },
  {
      "loctvl842/monokai-pro.nvim",
      config = function()
          require("monokai-pro").setup {
          filter = "machine", -- classic | octagon | pro | machine | ristretto | spectrum
      }
      end
  },
  -- import/override with your plugins folder
}
