return {
  "f-person/git-blame.nvim",
  event = "BufRead",
  config = function()
    vim.g.gitblame_enabled = 1
    vim.g.gitblame_message_template = "<author> • <date> • <summary>"
    vim.g.gitblame_highlight_group = "LineNr"
    vim.g.gitblame_delay = 500
    vim.g.gitblame_message_when_not_committed = "Not committed yet"
    vim.g.gitblame_date_format = "%r"
  end,
  keys = {
    { "<leader>tb", "<cmd>GitBlameToggle<CR>", desc = "Toggle git blame" },
  },
} 
