require("codecompanion").setup({
  strategies = {
      chat = {
        adapter = {
            name = 'gemini',
            model = 'gemini-2.5-pro'
        }
      },
      inline = {
        adapter = {
            name = 'gemini',
            model = 'gemini-2.5-pro'
        }
      },
  },
  adapters = {
      http = {
        gemini = function()
          return require("codecompanion.adapters").extend("gemini", {
            env = {
              api_key = vim.base64.decode(vim.env.GEMINI_KEY),
            },
          })
        end,
      },
  },
  prompt_library = require("NAMESPACE/codecompanion-prompt-library")
})
