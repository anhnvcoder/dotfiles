return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
    "stevearc/dressing.nvim",
  },
  config = function()
    local adapters = require("codecompanion.adapters")

    require("codecompanion").setup({
      adapters = {
        http = {
          opts = {
            show_presets = false,
            show_model_choices = false,
          },
          proxypal = function()
            return adapters.extend("openai_compatible", {
              formatted_name = "ProxyPal",
              env = {
                api_key = "proxypal-local",
                url = "http://127.0.0.1:8317",
                chat_url = "/v1/chat/completions",
                models_endpoint = "/v1/models",
              },
              handlers = {
                parse_message_meta = function(_, data)
                  local extra = data.extra or {}

                  if extra.reasoning_content then
                    data.output.reasoning = { content = extra.reasoning_content }
                    if data.output.content == "" then
                      data.output.content = nil
                    end
                  end

                  return data
                end,
              },
              schema = {
                model = {
                  default = "gpt-5.4",
                  choices = {
                    "gpt-5.4",
                  },
                },
              },
            })
          end,
        },
        acp = {
          opts = {
            show_presets = false,
          },
          opencode = function()
            return adapters.extend("opencode", {})
          end,
        },
      },
      interactions = {
        background = {
          adapter = "proxypal",
        },
        chat = {
          adapter = "opencode",
        },
        inline = {
          adapter = "proxypal",
        },
        cmd = {
          adapter = "proxypal",
        },
      },
    })

    local map = vim.keymap.set

    map({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", {
      noremap = true,
      silent = true,
      desc = "CodeCompanion Actions",
    })

    map({ "n", "v" }, "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", {
      noremap = true,
      silent = true,
      desc = "CodeCompanion Chat Toggle",
    })

    map("v", "ga", "<cmd>CodeCompanionChat Add<cr>", {
      noremap = true,
      silent = true,
      desc = "CodeCompanion Add to Chat",
    })

    vim.cmd([[cab cc CodeCompanion]])
  end,
}
