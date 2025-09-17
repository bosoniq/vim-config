require("codecompanion").setup({
  strategies = {
      chat = {
        adapter = 'gemini',
      },
      inline = {
        adapter = 'gemini',
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
