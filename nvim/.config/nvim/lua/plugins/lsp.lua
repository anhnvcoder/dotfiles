return {
  -- LSP Support
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Web development
        html = { mason = false },
        cssls = { mason = false },
        tailwindcss = { mason = false },
        emmet_ls = {
          mason = false,
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
        tsserver = { mason = false },
        ts_ls = { mason = false },
        volar = { mason = false },
        eslint = { mason = false },
        jsonls = { mason = false },
        pyright = { mason = false },
        ruff_lsp = { mason = false },
        terraformls = { mason = false },
        dockerls = { mason = false },
        docker_compose_language_service = { mason = false },
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
      },
    },
  },

  -- Mason
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- Web development
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

        -- Formatters
        "prettier", -- JavaScript formatter
        "black", -- Python formatter
        "isort", -- Python formatter
        "stylua", -- Lua formatter

        -- Linters
        "eslint_d", -- JavaScript linter
        "stylelint", -- CSS linter
        "jsonlint", -- JSON linter
        "shellcheck", -- Shell script linter
        "yamllint", -- YAML linter
        "ruff", -- Python linter
        "tflint", -- Terraform linter
        "hadolint", -- Dockerfile linter
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
      },
    },
  },

  { import = "lazyvim.plugins.extras.lang.terraform" },
  { import = "lazyvim.plugins.extras.lang.docker" },
  { import = "lazyvim.plugins.extras.lang.typescript" },
}
