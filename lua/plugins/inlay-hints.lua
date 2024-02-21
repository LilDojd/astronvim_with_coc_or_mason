return {
  {
    "lvimuser/lsp-inlayhints.nvim",
    event = "LspAttach",
    opts = {
      inlay_hints = {
        parameter_hints = {
          show = true,
          prefix = "<- ",
          separator = ", ",
          remove_colon_start = false,
          remove_colon_end = true,
        },
        type_hints = {
          -- type and other hints
          show = true,
          prefix = "-> ",
          separator = ", ",
          remove_colon_start = true,
          remove_colon_end = false,
        },
      },
    },
    keys = {
      {
        "<leader>ih",
        function() require("lsp-inlayhints").toggle() end,
        desc = "Hide inlay hints",
      },
    },
    config = function(_, opts)
      require("lsp-inlayhints").setup(opts)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("LspAttach_inlayhints", {}),
        callback = function(args)
          if not (args.data and args.data.client_id) then return end
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          require("lsp-inlayhints").on_attach(client, args.buf)
        end,
      })
    end,
  },
}
