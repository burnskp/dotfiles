return {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "theHamsta/nvim-dap-virtual-text",
      config = function()
        require("nvim-dap-virtual-text").setup()
      end,
      keys = {
        { "<leader>ib", "<cmd>lua require('dap').toggle_breakpoint()<cr>", desc = "Toggle Breakpoint" },
        { "<leader>ic", "<cmd>lua require('dap').continue()<cr>",          desc = "Continue" },
        { "<leader>id", "<cmd>lua require('dap').disconnect()<cr>",        desc = "Disconnect" },
        { "<leader>ii", "<cmd>lua require('dap').step_into()<cr>",         desc = "Step Into" },
        { "<leader>io", "<cmd>lua require('dap').step_over()<cr>",         desc = "Step Over" },
        { "<leader>ir", "<cmd>lua require('dap').repl.toggle()<cr>",       desc = "Toggle Repl" },
      }
    },
    {
      "rcarriga/nvim-dap-ui",
      config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        dapui.setup()
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close()
        end
      end,
    },
    {
      "mfussenegger/nvim-dap-python",
      ft = { "python" },
      config = function()
        local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
        require("dap-python").setup(path)
      end,
      keys = {
        {
          "<leader>ip",
          function()
            require("dap-python").test_method()
          end,
          desc = "Debug Python Method"
        },
      }
    },
    "leoluz/nvim-dap-go",
  },
}
