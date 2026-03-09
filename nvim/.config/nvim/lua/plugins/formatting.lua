return {
  -- Prettier/ESLint + format-on-save behavior similar to VSCode settings
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts = opts or {}

      opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft or {}, {
        javascript = { "prettierd", "prettier" },
        javascriptreact = { "prettierd", "prettier" },
        typescript = { "prettierd", "prettier" },
        typescriptreact = { "prettierd", "prettier" },
        vue = { "prettierd", "prettier" },
        astro = { "prettierd", "prettier" },
        html = { "prettierd", "prettier" },
        css = { "prettierd", "prettier" },
        scss = { "prettierd", "prettier" },
      })

      -- Global toggle: :let g:autoformat = v:false
      -- Buffer toggle: :let b:autoformat = v:false
      opts.format_on_save = function(bufnr)
        if vim.g.autoformat == false or vim.b[bufnr].autoformat == false then
          return nil
        end
        return {
          timeout_ms = 3000,
          lsp_fallback = true,
        }
      end

      return opts
    end,
  },

  -- TypeScript/JavaScript code actions like VSCode explicit actions
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts = opts or {}
      opts.servers = opts.servers or {}

      -- Works with LazyVim TS extra (vtsls)
      opts.servers.vtsls = vim.tbl_deep_extend("force", opts.servers.vtsls or {}, {
        settings = {
          typescript = {
            updateImportsOnFileMove = { enabled = "always" },
          },
          javascript = {
            updateImportsOnFileMove = { enabled = "always" },
          },
        },
      })

      return opts
    end,
    keys = {
      {
        "<leader>co",
        function()
          vim.lsp.buf.code_action({
            apply = true,
            context = { only = { "source.organizeImports" }, diagnostics = {} },
          })
        end,
        desc = "Code Action: Organize Imports",
      },
      {
        "<leader>ce",
        function()
          vim.lsp.buf.code_action({
            apply = true,
            context = { only = { "source.fixAll.eslint" }, diagnostics = {} },
          })
        end,
        desc = "Code Action: Fix All ESLint",
      },
      {
        "<leader>cm",
        function()
          vim.lsp.buf.code_action({
            apply = true,
            context = { only = { "source.addMissingImports" }, diagnostics = {} },
          })
        end,
        desc = "Code Action: Add Missing Imports",
      },
    },
  },

  -- Update imports when renaming/moving files from NvimTree
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-tree.lua",
    },
    config = true,
  },

  -- Ensure formatter/linter binaries are installed by Mason
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts = opts or {}
      opts.ensure_installed = opts.ensure_installed or {}

      local ensure = {
        "prettierd",
        "prettier",
        "eslint_d",
      }

      for _, pkg in ipairs(ensure) do
        if not vim.tbl_contains(opts.ensure_installed, pkg) then
          table.insert(opts.ensure_installed, pkg)
        end
      end

      return opts
    end,
  },
}
