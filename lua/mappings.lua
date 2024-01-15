local system = vim.loop.os_uname().sysname
local is_available = require("astrocore").is_available
local M = {}

function M.mappings(maps)
  maps.n["<Leader>n"] = false

  maps.n.n = { require("utils").better_search "n", desc = "Next search" }
  maps.n.N = { require("utils").better_search "N", desc = "Previous search" }

  maps.v["K"] = { ":move '<-2<CR>gv-gv", desc = "Move line up", silent = true }
  maps.v["J"] = { ":move '>+1<CR>gv-gv", desc = "Move line down", silent = true }

  maps.i["<C-s>"] = { "<esc>:w<cr>a", desc = "Save file", silent = true }

  maps.n["<Leader>wo"] = { "<C-w>o", desc = "Close other screen" }

  if vim.g.neovide then
    if system == "Darwin" then
      vim.g.neovide_input_use_logo = 1 -- enable use of the logo (cmd) key
      -- Save
      maps.n["<D-s>"] = ":w<CR>"
      -- Paste normal mode
      maps.n["<D-v>"] = '"+P'
      -- Copy
      maps.v["<D-c>"] = '"+y'
      -- Paste visual mode
      maps.v["<D-v>"] = '"+P'
      -- Paste command mode
      maps.c["<D-v>"] = "<C-R>+"
      -- Paste insert mode
      maps.i["<D-v>"] = '<esc>"+pli'

      -- Allow clipboard copy paste in neovim
      vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })
    end
  end

  if is_available "vim-jukit" then
    maps.n["<Leader>j"] = { desc = " Jupyter" }
    maps.v["<Leader>j"] = { desc = " Jupyter" }

    -- Open
    maps.n["<Leader>jo"] = { desc = "Open" }
    maps.n["<Leader>joo"] = {
      "<cmd>call jukit#splits#output()<CR>",
      desc = "Open ipython window",
    }
    maps.n["<Leader>jot"] = { "<cmd>call jukit#splits#term()<CR>", desc = "Open terminal window" }
    maps.n["<Leader>joh"] = { "<cmd>call jukit#splits#history()<CR>", desc = "Open history window" }
    maps.n["<Leader>joa"] =
      { "<cmd>call jukit#splits#output_and_history()<CR>", desc = "Open terminal and history window" }

    -- Close
    maps.n["<Leader>jc"] = { desc = "Close" }
    maps.n["<Leader>jch"] = { "<cmd>call jukit#splits#close_history()<CR>", desc = "Close output history window" }
    maps.n["<Leader>jco"] = { "<cmd>call jukit#splits#close_output_split()<CR>", desc = "Close output window" }
    -- Argument: Whether or not to ask you to confirm before closing
    maps.n["<Leader>jca"] = { "<cmd>call jukit#splits#close_output_and_history(1)<CR>", desc = "Close both windows" }

    -- Show
    maps.n["<Leader>jS"] = { desc = "Show" }
    maps.n["<Leader>jSc"] =
      { "<cmd>call jukit#splits#show_last_cell_output(1)<CR>", desc = "Show last cell output in output history window" }

    -- Scroll
    maps.n["<Leader>js"] = { desc = "Scroll" }
    maps.n["<Leader>jsj"] = { "<cmd>call jukit#splits#out_hist_scroll(1)<CR>", desc = "Scroll down in history window" }
    maps.n["<Leader>jsk"] = { "<cmd>call jukit#splits#out_hist_scroll(0)<CR>", desc = "Scroll up in history window" }

    -- UI autocmd
    maps.n["<Leader>ju"] = { desc = "UI" }
    maps.n["<Leader>juh"] =
      { "<cmd>call jukit#splits#toggle_auto_hist()", desc = "Toggle auto displaying saved output on CursorHold" }
    maps.n["<Leader>jul"] = { "<cmd>call jukit#layouts#set_layout()<CR>", desc = "Apply layout to current splits" }
    maps.n["<Leader>jup"] =
      { "<cmd>call jukit#ueberzug#set_default_pos()<CR>", desc = "Set position and dimension of ueberzug window" }

    -- Execute
    maps.n["<Leader>je"] = { desc = "Execute" }
    maps.v["<Leader>je"] = { desc = "Execute" }
    maps.n["<Leader>jer"] = { "<cmd>call jukit#send#section(0)<CR>", desc = "Execute current cell" }
    maps.n["<Leader>jel"] = { "<cmd>call jukit#send#line()<CR>", desc = "Execute current line" }
    maps.v["<Leader>jer"] = { "<cmd>call jukit#send#selection()<CR>", desc = "Execute selected code" }
    maps.n["<Leader>jeu"] =
      { "<cmd>call jukit#send#until_current_section()<CR>", desc = "Execute all cells until current cell" }
    maps.n["<Leader>jea"] = { "<cmd>call jukit#send#all()<CR>", desc = "Execute all cells" }

    -- Cell
    maps.n["<Leader>jj"] = { desc = "Cell" }
    maps.n["<Leader>jjo"] = { "<cmd>call jukit#cells#create_below(0)<CR>", desc = "Create code cell below" }
    maps.n["<Leader>jjO"] = { "<cmd>call jukit#cells#create_above(0)<CR>", desc = "Create code cell above" }
    maps.n["<Leader>jjt"] = { "<cmd>call jukit#cells#create_below(1)<CR>", desc = "Create markdown cell below" }
    maps.n["<Leader>jjT"] = { "<cmd>call jukit#cells#create_above(1)<CR>", desc = "Create markdown cell above" }
    maps.n["<Leader>jjd"] = { "<cmd>call jukit#cells#delete()<CR>", desc = "Delete current cell" }
    maps.n["<Leader>jjs"] = { "<cmd>call jukit#cells#split()<CR>", desc = "Split current cell" }
    maps.n["<Leader>jjm"] =
      { "<cmd>call jukit#cells#merge_below()<CR>", desc = "Merge current cell with the cell below" }
    maps.n["<Leader>jjM"] =
      { "<cmd>call jukit#cells#merge_above()<CR>", desc = "Merge current cell with the cell above" }
    maps.n["<Leader>jjK"] = { "<cmd>call jukit#cells#move_up()<CR>", desc = "Move current cell up" }
    maps.n["<Leader>jjJ"] = { "<cmd>call jukit#cells#move_down()<CR>", desc = "Move current cell down" }
    maps.n["<Leader>jjj"] = { "<cmd>call jukit#cells#jump_to_next_cell()<CR>", desc = "Jump to next cell below" }
    maps.n["<Leader>jjk"] =
      { "<cmd>call jukit#cells#jump_to_previous_cell()<CR>", desc = "Jump to previous cell above" }
    maps.n["<Leader>jjc"] = { "<cmd>call jukit#cells#delete_outputs(0)<CR>", desc = "Clear current cell output" }
    maps.n["<Leader>jja"] = { "<cmd>call jukit#cells#delete_outputs(1)<CR>", desc = "Clear all cell output" }

    -- Conversion
    maps.n["<Leader>jm"] = { desc = "Conversion" }
    maps.n["<Leader>jmj"] =
      { "<cmd>call jukit#convert#notebook_convert('jupyter-notebook')<CR>", desc = "Convert py to jupyter notebook" }
    if vim.g.jukit_html_viewer then
      maps.n["<Leader>jmt"] =
        { "<cmd>call jukit#convert#save_nb_to_file(0,1,'html')<CR>", desc = "Convert file to html" }
      maps.n["<Leader>jmT"] =
        { "<cmd>call jukit#convert#save_nb_to_file(1,1,'html')<CR>", desc = "Convert file to html with rerun all code" }
    end

    if vim.g.jukit_pdf_viewer then
      maps.n["<Leader>jmp"] = { "<cmd>call jukit#convert#save_nb_to_file(0,1,'pdf')<CR>", desc = "Convert file to pdf" }
      maps.n["<Leader>jmP"] =
        { "<cmd>call jukit#convert#save_nb_to_file(1,1,'pdf')<CR>", desc = "Convert file to pdf with rerun all code" }
    end

    -- Env
    maps.n["<Leader>jn"] = { desc = "Env" }
    maps.n["<Leader>jnc"] = { ":JukitOut conda activate ", desc = "Activate conda env" }
    maps.n["<Leader>jnC"] = { ":JukitOutHist conda activate ", desc = "Activate conda env with history window" }
  end

  if is_available "cellular-automaton.nvim" then
    maps.n["<Leader>um"] = { "<cmd>CellularAutomaton make_it_rain<CR>", desc = "Make it rain" }
    maps.n["<Leader>uM"] = { "<cmd>CellularAutomaton game_of_life<CR>", desc = "Game of life" }
  end

  -- telescope plugin mappings
  if is_available "telescope.nvim" then
    maps.v["<Leader>f"] = { desc = "󰍉 Find" }
    maps.n["<Leader>fT"] = { "<cmd>TodoTelescope<cr>", desc = "Find TODOs" }
    -- buffer switching
    maps.n["<Leader>bt"] = {
      function()
        if #vim.t.bufs > 1 then
          require("telescope.builtin").buffers { sort_mru = true, ignore_current_buffer = true }
        else
          require("astrocore").notify "No other buffers open"
        end
      end,
      desc = "Switch Buffers In Telescope",
    }
  end

  if is_available "nvim-dap-ui" then
    maps.n["<Leader>dU"] = {
      function() require("dapui").toggle { reset = true } end,
      desc = "Toggle Debugger UI and reset layout",
    }
    if is_available "persistent-breakpoints.nvim" then
      maps.n["<F9>"] = {
        function() require("persistent-breakpoints.api").toggle_breakpoint() end,
        desc = "Debugger: Toggle Breakpoint",
      }
      maps.n["<Leader>db"] = {
        function() require("persistent-breakpoints.api").toggle_breakpoint() end,
        desc = "Toggle Breakpoint (F9)",
      }
      maps.n["<Leader>dB"] = {
        function() require("persistent-breakpoints.api").clear_all_breakpoints() end,
        desc = "Clear All Breakpoints",
      }
      maps.n["<Leader>dC"] = {
        function() require("persistent-breakpoints.api").set_conditional_breakpoint() end,
        desc = "Conditional Breakpoint (S-F9)",
      }
      maps.n["<F21>"] = {
        function() require("persistent-breakpoints.api").set_conditional_breakpoint() end,
        desc = "Conditional Breakpoint (S-F9)",
      }
    end
  end

  -- close mason
  if is_available "refactoring.nvim" then
    maps.n["<Leader>r"] = { desc = " Refactor" }
    maps.v["<Leader>r"] = { desc = " Refactor" }
    maps.x["<Leader>r"] = { desc = " Refactor" }
    maps.n["<Leader>rb"] = {
      function() require("refactoring").refactor "Extract Block" end,
      desc = "Extract Block",
    }
    maps.n["<Leader>ri"] = {
      function() require("refactoring").refactor "Inline Variable" end,
      desc = "Inline Variable",
    }
    maps.n["<Leader>rp"] = {
      function() require("refactoring").debug.printf { below = false } end,
      desc = "Debug: Print Function",
    }
    maps.n["<Leader>rc"] = {
      function() require("refactoring").debug.cleanup {} end,
      desc = "Debug: Clean Up",
    }
    maps.n["<Leader>rd"] = {
      function() require("refactoring").debug.print_var { below = false } end,
      desc = "Debug: Print Variable",
    }
    maps.n["<Leader>rbf"] = {
      function() require("refactoring").refactor "Extract Block To File" end,
      desc = "Extract Block To File",
    }

    maps.x["<Leader>re"] = {
      function() require("refactoring").refactor "Extract Function" end,
      desc = "Extract Function",
    }
    maps.x["<Leader>rf"] = {
      function() require("refactoring").refactor "Extract Function To File" end,
      desc = "Extract Function To File",
    }
    maps.x["<Leader>rv"] = {
      function() require("refactoring").refactor "Extract Variable" end,
      desc = "Extract Variable",
    }
    maps.x["<Leader>ri"] = {
      function() require("refactoring").refactor "Inline Variable" end,
      desc = "Inline Variable",
    }

    maps.v["<Leader>re"] = {
      function() require("refactoring").refactor "Extract Function" end,
      desc = "Extract Function",
    }
    maps.v["<Leader>rf"] = {
      function() require("refactoring").refactor "Extract Function To File" end,
      desc = "Extract Function To File",
    }
    maps.v["<Leader>rv"] = {
      function() require("refactoring").refactor "Extract Variable" end,
      desc = "Extract Variable",
    }
    maps.v["<Leader>ri"] = {
      function() require("refactoring").refactor "Inline Variable" end,
      desc = "Inline Variable",
    }
    maps.v["<Leader>rb"] = {
      function() require("refactoring").refactor "Extract Block" end,
      desc = "Extract Block",
    }
    maps.v["<Leader>rbf"] = {
      function() require("refactoring").refactor "Extract Block To File" end,
      desc = "Extract Block To File",
    }
    maps.v["<Leader>rr"] = {
      function() require("refactoring").select_refactor() end,
      desc = "Select Refactor",
    }
    maps.v["<Leader>rp"] = {
      function() require("refactoring").debug.printf { below = false } end,
      desc = "Debug: Print Function",
    }
    maps.v["<Leader>rc"] = {
      function() require("refactoring").debug.cleanup {} end,
      desc = "Debug: Clean Up",
    }
    maps.v["<Leader>rd"] = {
      function() require("refactoring").debug.print_var { below = false } end,
      desc = "Debug: Print Variable",
    }
  end

  if is_available "noice.nvim" then
    local noice_down = function()
      if not require("noice.lsp").scroll(4) then return "<C-d>" end
    end
    local noice_up = function()
      if not require("noice.lsp").scroll(-4) then return "<C-u>" end
    end

    maps.n["<C-d>"] = {
      noice_down,
      desc = "Scroll down",
      silent = true,
      expr = true,
    }
    maps.i["<C-d>"] = {
      noice_down,
      desc = "Scroll down",
      silent = true,
      expr = true,
    }
    maps.s["<C-d>"] = {
      noice_down,
      desc = "Scroll down",
      silent = true,
      expr = true,
    }
    maps.n["<C-u>"] = {
      noice_up,
      desc = "Scroll down",
      silent = true,
      expr = true,
    }
    maps.i["<C-u>"] = {
      noice_up,
      desc = "Scroll down",
      silent = true,
      expr = true,
    }
    maps.s["<C-u>"] = {
      noice_up,
      desc = "Scroll down",
      silent = true,
      expr = true,
    }
  end

  if system == "Darwin" or system == "Linux" then
    if is_available "Comment.nvim" then
      maps.n["<C-/>"] = {
        function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end,
        desc = "Comment line",
      }
      maps.v["<C-/>"] = {
        "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
        desc = "Toggle comment line",
      }
      maps.n["<Leader>/"] = false
      maps.n["<Leader>/"] = false
    end
  end

  if is_available "dial.nvim" then
    maps.v["<C-a>"] = {
      function() return require("dial.map").manipulate("increment", "visual") end,
      desc = "Increment",
    }
    maps.v["<C-x>"] = {
      function() return require("dial.map").manipulate("decrement", "visual") end,
      desc = "Decrement",
    }
    maps.v["g<C-a>"] = {
      function() return require("dial.map").manipulate("increment", "gvisual") end,
      desc = "Increment",
    }
    maps.v["g<C-x>"] = {
      function() return require("dial.map").manipulate("decrement", "gvisual") end,
      desc = "Decrement",
    }
    maps.n["<C-a>"] = {
      function() return require("dial.map").manipulate("increment", "normal") end,
      desc = "Increment",
    }
    maps.n["<C-x>"] = {
      function() return require("dial.map").manipulate("decrement", "normal") end,
      desc = "Decrement",
    }
    maps.n["g<C-a>"] = {
      function() return require("dial.map").manipulate("increment", "gnormal") end,
      desc = "Increment",
    }
    maps.n["g<C-x>"] = {
      function() return require("dial.map").manipulate("decrement", "gnormal") end,
      desc = "Decrement",
    }
  end

  if is_available "marks.nvim" then
    -- print(require("astrocore").is_available "marks.nvim")
    -- marks
    maps.n["m"] = { desc = "󰈚 Marks" }
    maps.n["m,"] = { "<Plug>(Marks-setnext)<CR>", desc = "Set Next Lowercase Mark" }
    maps.n["m;"] = { "<Plug>(Marks-toggle)<CR>", desc = "Toggle Mark(Set Or Cancel Mark)" }
    maps.n["m]"] = { "<Plug>(Marks-next)<CR>", desc = "Move To Next Mark" }
    maps.n["m["] = { "<Plug>(Marks-prev)<CR>", desc = "Move To Previous Mark" }
    maps.n["m:"] = { "<Plug>(Marks-preview)", desc = "Preview Mark" }

    maps.n["dm"] = { "<Plug>(Marks-delete)", desc = "Delete Marks" }
    maps.n["dm-"] = { "<Plug>(Marks-deleteline)<CR>", desc = "Delete All Marks On The Current Line" }
    maps.n["dm<space>"] = { "<Plug>(Marks-deletebuf)<CR>", desc = "Delete All Marks On Current Buffer" }
  end

  -- close search highlight
  maps.n["<Leader>nh"] = { ":nohlsearch<CR>", desc = "Close search highlight" }

  maps.n["<Leader><Leader>"] = { desc = "󰍉 User" }
  maps.n["s"] = "<Nop>"

  maps.n["H"] = { "^", desc = "Go to start without blank" }
  maps.n["L"] = { "$", desc = "Go to end without blank" }

  if is_available "vim-visual-multi" then
    -- visual multi
    vim.g.VM_maps = {
      ["Find Under"] = "<C-n>",
      ["Find Subword Under"] = "<C-n>",
      ["Add Cursor Up"] = "<C-S-k>",
      ["Add Cursor Down"] = "<C-S-j>",
      ["Select All"] = "<C-S-n>",
      ["Skip Region"] = "<C-x>",
    }
  end

  maps.v["<"] = { "<gv", desc = "Unindent line" }
  maps.v[">"] = { ">gv", desc = "Indent line" }

  if is_available "toggleterm.nvim" then
    if vim.fn.executable "lazygit" == 1 then
      maps.n["<Leader>tl"] = {
        require("utils").toggle_lazy_git(),
        desc = "ToggleTerm lazygit",
      }
      maps.n["<Leader>gg"] = maps.n["<Leader>tl"]
    end
    if vim.fn.executable "joshuto" == 1 then
      maps.n["<Leader>tj"] = {
        require("utils").toggle_joshuto(),
        desc = "ToggleTerm joshuto",
      }
    end
  end

  -- 在visual mode 里粘贴不要复制
  maps.n["x"] = { '"_x', desc = "Cut without copy" }

  -- 分屏快捷键
  maps.n["<Leader>w"] = { desc = "󱂬 Window" }
  maps.n["<Leader>ww"] = { "<cmd><cr>", desc = "Save" }
  maps.n["<Leader>wc"] = { "<C-w>c", desc = "Close current screen" }
  maps.n["<Leader>wo"] = { "<C-w>o", desc = "Close other screen" }
  -- 多个窗口之间跳转
  maps.n["<Leader>w="] = { "<C-w>=", desc = "Make all window equal" }
  maps.n["<TAB>"] =
    { function() require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end, desc = "Next buffer" }
  maps.n["<S-TAB>"] = {
    function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
    desc = "Previous buffer",
  }
  maps.n["<Leader>bo"] =
    { function() require("astrocore.buffer").close_all(true) end, desc = "Close all buffers except current" }
  maps.n["<Leader>ba"] = { function() require("astrocore.buffer").close_all() end, desc = "Close all buffers" }
  maps.n["<Leader>bc"] = { function() require("astrocore.buffer").close() end, desc = "Close buffer" }
  maps.n["<Leader>bC"] = { function() require("astrocore.buffer").close(0, true) end, desc = "Force close buffer" }
  maps.n["<Leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" }
  maps.n["<Leader>bD"] = {
    function()
      require("astrocore.status").heirline.buffer_picker(function(bufnr) require("astrocore.buffer").close(bufnr) end)
    end,
    desc = "Pick to close",
  }

  -- lsp restart
  maps.n["<Leader>lm"] = { "<Cmd>LspRestart<CR>", desc = "Lsp restart" }
  maps.n["<Leader>lg"] = { "<Cmd>LspLog<CR>", desc = "Show lsp log" }

  if is_available "flash.nvim" then
    maps.n["<Leader>s"] = {
      function() require("flash").jump() end,
      desc = "Flash",
    }
    maps.x["<Leader>s"] = {
      function() require("flash").jump() end,
      desc = "Flash",
    }
    maps.o["<Leader>s"] = {
      function() require("flash").jump() end,
      desc = "Flash",
    }
    maps.n["<Leader><Leader>s"] = {
      function() require("flash").treesitter() end,
      desc = "Flash Treesitter",
    }
    maps.x["<Leader><Leader>s"] = {
      function() require("flash").treesitter() end,
      desc = "Flash Treesitter",
    }
    maps.o["<Leader><Leader>s"] = {
      function() require("flash").treesitter() end,
      desc = "Flash Treesitter",
    }
  end

  if is_available "substitute.nvim" then
    -- substitute, 交换和替换插件, 寄存器中的值，将会替换到s位置, s{motion}
    maps.n["s"] = { require("substitute").operator, desc = "Replace with {motion}" }
    maps.n["ss"] = { require("substitute").line, desc = "Replace with line" }
    maps.n["S"] = { require("substitute").eol, desc = "Replace until eol" }
    maps.v["p"] = { require("substitute").visual, desc = "Replace in visual" }
    -- exchange
    maps.n["sx"] = { require("substitute.exchange").operator, desc = "Exchange with {motion}" }
    maps.n["sxx"] = { require("substitute.exchange").line, desc = "Exchange with line" }
    maps.n["sxc"] = { require("substitute.exchange").cancel, desc = "Exchange exchange" }
    maps.v["X"] = { require("substitute.exchange").visual, desc = "Exchange in visual" }
  end

  if is_available "nvim-treesitter" then
    -- TsInformation
    maps.n["<Leader>lT"] = { "<cmd>TSInstallInfo<cr>", desc = "Tree sitter Information" }
  end

  return maps
end

return M
