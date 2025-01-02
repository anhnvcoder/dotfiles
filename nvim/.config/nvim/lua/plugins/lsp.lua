vim.g.lazyvim_php_lsp = "intelephense"

return {
  -- Language support
  { import = "lazyvim.plugins.extras.lang.terraform" },
  { import = "lazyvim.plugins.extras.lang.docker" },
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.php" },
  -- LSP Support
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Web development
        html = {},
        cssls = {},
        tailwindcss = {},
        emmet_ls = {
          filetypes = {
            "html",
            "typescriptreact",
            "javascriptreact",
            "css",
            "sass",
            "scss",
            "less",
            "vue",
          },
        },
        tsserver = {},
        volar = {},
        eslint = {},
        jsonls = {},
        pyright = {},
        ruff_lsp = {},
        terraformls = {},
        dockerls = {},
        docker_compose_language_service = {},
        intelephense = {},
      },
    },
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        "terraform",
        "hcl",
        "dockerfile",
        "php",
      },
    },
  },

  -- Mason
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- LSP
        "html-lsp",
        "css-lsp",
        "tailwindcss-language-server",
        "emmet-ls",
        "typescript-language-server",
        "vue-language-server",
        "eslint-lsp",
        "json-lsp",
        "pyright",
        "ruff-lsp",
        "terraform-ls",
        "dockerfile-language-server",
        "docker-compose-language-service",
        "intelephense",

        -- PHP Tools
        "phpcs",
        "php-cs-fixer",

        -- Formatters
        "prettier",
        "black",
        "isort",
        "stylua",

        -- Linters
        "eslint_d",
        "stylelint",
        "jsonlint",
        "shellcheck",
        "yamllint",
        "ruff",
        "tflint",
        "hadolint",
      },
    },
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        vue = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        python = { "isort", "black" },
        terraform = { "terraform_fmt" },
        tf = { "terraform_fmt" },
        ["terraform-vars"] = { "terraform_fmt" },
        lua = { "stylua" },
        dockerfile = { "prettier" },
        ["docker-compose"] = { "prettier" },
      },
    },
  },

  -- Linting
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        vue = { "eslint_d" },
        css = { "stylelint" },
        scss = { "stylelint" },
        python = { "ruff" },
        terraform = { "tflint" },
        yaml = { "yamllint" },
        json = { "jsonlint" },
        sh = { "shellcheck" },
        dockerfile = { "hadolint" },
        ["docker-compose"] = { "yamllint" },
        php = { "phpcs" },
      },
    },
  },
}
