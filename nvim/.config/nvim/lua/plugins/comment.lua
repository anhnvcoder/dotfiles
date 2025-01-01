return {
  {
    'numToStr/Comment.nvim',
    opts = {
      -- Thêm comment cho ngôn ngữ đang dùng
      toggler = {
        line = 'gcc',  -- Comment/uncomment dòng hiện tại
        block = 'gbc', -- Comment/uncomment block
      },
      -- Phím tắt cho visual mode
      opleader = {
        line = 'gc',
        block = 'gb',
      },
      -- Thêm khoảng trắng sau comment
      padding = true,
      -- Tự động nhận dạng comment style của file
      sticky = true,
      -- Giữ con trỏ ở vị trí hiện tại
      ignore = nil,
      -- Mapping tùy chỉnh
      mappings = {
        basic = true,   -- gcc, gc, gbc, gb
        extra = false,  -- gco, gcO, gcA
      },
    },
    keys = {
      { "gcc", mode = "n", desc = "Comment toggle current line" },
      { "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
      { "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
      { "gbc", mode = "n", desc = "Comment toggle current block" },
      { "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
      { "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
    },
  }
} 
