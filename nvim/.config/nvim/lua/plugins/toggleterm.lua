return {
  { "akinsho/toggleterm.nvim", version = "*", opts = {
    open_mapping = "<C-t>",
    direction = "horizontal",
    dir = "%:p:h",
    float_opts = {
      border = "curved",
    },
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
    on_open = function(term)
      vim.cmd("startinsert!")
      -- Tắt số dòng trong terminal
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
    end,
    on_close = function(term)
      vim.cmd("stopinsert!")
    end,
    -- Tự động vào insert mode khi mở terminal
    start_in_insert = true,
    -- Tự động vào insert mode khi chuyển tới buffer terminal
    insert_mappings = true,
    terminal_mappings = true,
  },
  keys = {
    -- Terminal keymaps
    { "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", desc = "Toggle floating terminal" },
    { "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Toggle horizontal terminal" },
    { "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", desc = "Toggle vertical terminal" },
    -- Toggle giữa các terminal instances
    { "<leader>t1", "<cmd>1ToggleTerm<cr>", desc = "Toggle terminal #1" },
    { "<leader>t2", "<cmd>2ToggleTerm<cr>", desc = "Toggle terminal #2" },
    { "<leader>t3", "<cmd>3ToggleTerm<cr>", desc = "Toggle terminal #3" },
    -- Terminal mode mappings
    { "<C-x>", [[<C-\><C-n><C-w>c]], mode = "t", desc = "Close terminal" },
    { "<Esc>", [[<C-\><C-n>]], mode = "t", desc = "Exit terminal mode" },
  },}
}
