return {
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    name = "catppuccin",
    config = function()
    require("catppuccin").setup {}
    end,
  },
  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = {
      colorscheme = "catppuccin",
      highlights = {
        init = function()
          local get_hlgroup = require("astroui").get_hlgroup
          return {
            CursorLineFold = { link = "CursorLineNr" }, -- highlight fold indicator as well as line number
            GitSignsCurrentLineBlame = { fg = get_hlgroup("NonText").fg, italic = true }, -- italicize git blame virtual text
            HighlightURL = { underline = true }, -- always underline URLs
            OctoEditable = { fg = "NONE", bg = "NONE" }, -- use treesitter for octo.nvim highlighting
          }
        end,
      },
    },
  },
}
