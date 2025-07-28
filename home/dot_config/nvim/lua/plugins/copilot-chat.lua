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
    cmd = { "CopilotChat", "CopilotChatOpen", "CopilotChatPrompts" },
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    opts = function()
      -- Read prompts from ~/.config/nvim/prompts
      local function load_prompts()
        local prompts = {}
        local files = vim.fn.glob(vim.fn.stdpath('config') .. '/prompts/*.txt', false, true)
        for _, path in ipairs(files) do
          local prompt = vim.fn.fnamemodify(path, ':t:r')
          local content = {}
          local f = io.open(path, 'r')
          if f then
            content = f:read("*all")
            f:close()
            prompts[prompt] = {
              prompt = content
            }
          end
        end
        prompts["Commit"].context = 'git:staged'
        return prompts
      end

      return {
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
        prompts = load_prompts()
      }
    end,
    keys = {
      {
        "<leader>ca",
        false,
      },
      {
        "<leader>cc",
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
        "<leader>cc",
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
        "<leader>cd",
        "<cmd>CopilotChatDocs<cr>",
        desc = "Document Code",
        mode = { "n", "v" },
      },
      {
        "<leader>cf",
        "<cmd>CopilotChatFix<cr>",
        desc = "Fix Code",
        mode = { "n", "v" },
      },
      {
        "<leader>co",
        "<cmd>CopilotChatOptimize<cr>",
        desc = "Optimize Code",
        mode = { "n", "v" },
      },
      {
        "<leader>cp",
        function()
          require("CopilotChat").select_prompt()
        end,
        desc = "Prompt Actions",
        mode = { "n", "v" },
      },
      {
        "<leader>cr",
        "<cmd>CopilotChatReview<cr>",
        desc = "Review Code",
        mode = { "n", "v" },
      },
      {
        "<leader>ct",
        "<cmd>CopilotChatTests<cr>",
        desc = "Add Tests to Code",
        mode = { "n", "v" },
      },
      {
        "<leader>cq",
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
