return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      sugestion = { enabled = false, },
      panel = { enabled = false },
      filetypes = {
        yaml = true,
      }
    }
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      "zbirenbaum/copilot.lua",
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    opts = {
      auto_insert_mode = true,
      question_header = " User",
      answer_header = " Copilot ",
      window = {
        width = 0.4,
      },
      mappings = {
        reset = {
          normal = "<C-r>",
          insert = "<C-r>",
        },
      },
    },
    keys = {
      {
        "<leader>Aa",
        false,
      },
      {
        "<leader>Ac",
        function()
          return require("CopilotChat").toggle({
            selection = function()
              return nil
            end,
          })
        end,
        desc = "Toggle",
        mode = { "n" },
      },
      {
        "<leader>Ac",
        function()
          return require("CopilotChat").open({
            selection = function(source)
              return require("CopilotChat.select").visual(source) or nil
            end,
          })
        end,
        desc = "Toggle",
        mode = { "v" },
      },
      {
        "<leader>Ad",
        "<cmd>CopilotChatDocs<cr>",
        desc = "Document Code",
        mode = { "n", "v" },
      },
      {
        "<leader>Af",
        "<cmd>CopilotChatFix<cr>",
        desc = "Fix Code",
        mode = { "n", "v" },
      },
      {
        "<leader>Ao",
        "<cmd>CopilotChatOptimize<cr>",
        desc = "Optimize Code",
        mode = { "n", "v" },
      },
      {
        "<leader>Ap",
        function()
          require("CopilotChat").select_prompt()
        end,
        desc = "Prompt Actions",
        mode = { "n", "v" },
      },
      {
        "<leader>At",
        "<cmd>CopilotChatTests<cr>",
        desc = "Add Tests to Code",
        mode = { "n", "v" },
      },
      {
        "<leader>Aq",
        function()
          vim.ui.input({
            prompt = "Quick Chat: ",
          }, function(input)
            if input ~= "" then
              require("CopilotChat").ask(input)
            end
          end)
        end,
        desc = "Quick Chat",
        mode = { "n", "v" },
      },
    },
  },
}
