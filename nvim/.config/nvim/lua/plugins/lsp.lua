return {
  -- Language support (LazyVim extras)
  { import = "lazyvim.plugins.extras.lang.go" },
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.tailwind" },
  { import = "lazyvim.plugins.extras.lang.astro" },
  { import = "lazyvim.plugins.extras.lang.vue" },

  -- LSP Support (explicit Go config; web stacks come from extras above)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {},
      },
    },
  },

  -- Treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- Go
        "go",
        "gomod",
        "gowork",
        "gosum",

        -- Web / Frontend
        "html",
        "css",
        "scss",
        "javascript",
        "typescript",
        "tsx",
        "astro",
        "vue",
      },
    },
  },

  -- Mason tools (LSP/formatter/linter binaries)
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- Go
        "gopls",
        "goimports",
        "gofumpt",
        "gomodifytags",
        "impl",
        "delve",

        -- JS/TS + Next/Nuxt ecosystem
        "typescript-language-server",
        "eslint-lsp",
        "tailwindcss-language-server",
        "emmet-language-server",

        -- HTML/CSS/SCSS
        "html-lsp",
        "css-lsp",

        -- Astro / Vue
        "astro-language-server",
        "vue-language-server",
      },
    },
  },
}
