return {
  {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
    opts = {
      check_ts = true, -- Enable treesitter
      ts_config = {
        lua = { "string" }, -- Don't add pairs in lua string treesitter nodes
        javascript = { "template_string" }, -- Don't add pairs in javscript template_string treesitter nodes
        java = false, -- Don't check treesitter on java
      },
      -- Disable autopairs for specific filetype
      disable_filetype = { "TelescopePrompt", "vim" },
      -- Don't add pairs if it already has a close pair in the same line
      enable_check_bracket_line = false,
      -- Will not add pair on that line, if it already has a close pair in the last col
      enable_afterquote = true,
      -- Add spaces between parentheses
      enable_moveright = true,
      -- Enable fast wrap feature
      fast_wrap = {
        map = "<M-e>", -- Alt+e to fast wrap
        chars = { "{", "[", "(", '"', "'" },
        pattern = [=[[%'%"%>%]%)%}%,]]=],
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "Search",
        highlight_grey = "Comment",
      },
    },
    config = function(_, opts)
      local npairs = require("nvim-autopairs")
      npairs.setup(opts)

      -- Tích hợp với nvim-cmp sau khi đã load
      local ok, cmp = pcall(require, "cmp")
      if ok then
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end
    end,
  },
} 
