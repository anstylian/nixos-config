if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  "avante.nvim",
  opts = {
    provider = "ollama",
    ollama = {
      endpoint = "http://localhost:11434",  -- Change this to your local Ollama server's URL
      model = "llama",                      -- Replace with your preferred model
      timeout = 30000,                       -- Timeout in milliseconds
      temperature = 0,
      max_tokens = 4096,
      ["local"] = true,                      -- Set to true for local use
    },
    vendors = {
      ollama = {
        ["local"] = true,
        endpoint = "127.0.0.1:11434/v1",
        model = "qwen2.5-coder",
        parse_curl_args = function(opts, code_opts)

        return {
          url = opts.endpoint .. "/chat/completions",
          headers = {
            ["Accept"] = "application/json",
            ["Content-Type"] = "application/json",
          },
          body = {
            model = opts.model,
            messages = require("avante.providers").copilot.parse_message(code_opts), -- you can make your own message, but this is very advanced
            max_tokens = 2048,
            stream = true,
          },
        }
        end,
      }
    },
  }
}
