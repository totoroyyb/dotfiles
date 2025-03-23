return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      -- transparent = true,
      style = "moon",
      styles = {
        -- sidebars = "transparent",
        -- floats = "transparent",
      },
      on_colors = function(c)
        c.border = c.blue7
      end,
    },
  },
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        separator_style = "slant",
      },
    },
  },
}
