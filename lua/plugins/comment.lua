return {
  "numToStr/Comment.nvim",
  lazy=false,
  opts = function(_, opts)
    local ft = require "Comment.ft"
    ft.thrift = { "//%s", "/*%s*/" }
    ft.goctl = { "//%s", "/*%s*/" }
  end,
}
