return {
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    version = "*",
    opts = {
      options = {
        mode = "buffers",
        separator_style = "thin",
        always_show_bufferline = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        color_icons = true,
      },
    },
    keys = {
      { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev buffer" },
      { "<leader>bc", "<Cmd>BufferLinePickClose<CR>", desc = "Close buffer" },
      { "<leader>bh", "<Cmd>BufferLineCloseLeft<CR>", desc = "Close all buffers to the left" },
      { "<leader>bl", "<Cmd>BufferLineCloseRight<CR>", desc = "Close all buffers to the right" },
      { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Close all other buffers" },
    },
  },
}
