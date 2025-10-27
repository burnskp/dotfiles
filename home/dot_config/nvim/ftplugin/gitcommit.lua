vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("gitcommit-copilotchat", { clear = true }),
  pattern = "COMMIT_EDITMSG",
  once = true,
  callback = function()
    local chat = require("CopilotChat")
    local buf = vim.api.nvim_get_current_buf()
    chat.ask(chat.prompts().Commit.prompt, {
      selection = require("CopilotChat.select").buffer,
      context = chat.prompts().Commit.context,
      model = "gpt-4.1",
      headless = true,
      callback = function(response)
        -- Extract content between first code block markers
        local commit_msg = response:match("```[%w]*\n(.-)\n?```")
        local lines
        if commit_msg then
          lines = vim.split(commit_msg, "\n", { plain = true })
        else
          lines = { "# Error: Unable to generate commit", "#" }
          for _, line in ipairs(vim.split(response, "\n", { plain = true })) do
            table.insert(lines, "# " .. line)
          end
        end
        vim.api.nvim_buf_set_lines(buf, 0, 0, false, lines)
        return response
      end,
    })
    chat.ask(chat.prompts().Review.prompt, {
      selection = require("CopilotChat.select").buffer,
      context = "git:staged",
      model = "gpt-4.1",
    })
  end,
})
