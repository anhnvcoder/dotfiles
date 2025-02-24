return {
  -- Language support
  { import = "lazyvim.plugins.extras.lang.go" },
  -- LSP Support
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Go development
        gopls = {},
      },
    },
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "go",
        "gomod",
        "gowork",
        "gosum",
      },
    },
  },

  -- Mason
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls",
        "goimports",
        "gofumpt",
        "gomodifytags",
        "impl",
        "delve",
      },
    },
  },
}
