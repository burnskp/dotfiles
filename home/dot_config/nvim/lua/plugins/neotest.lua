return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-neotest/neotest-go",
    "nvim-neotest/neotest-python",
  },
  config = function()
    local neotest_ns = vim.api.nvim_create_namespace("neotest")
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
          return message
        end,
      },
    }, neotest_ns)
    require("neotest").setup({
      adapters = {
        ["neotest-go"] = {
          recursive_run = true,
        },
      },
      require("neotest-python")({
        dap = { justMyCode = false },
      }),
      consumers = {
        notify = function(client)
          client.listeners.results = function(_, results, partial)
            -- Partial results can be very frequent
            if partial then
              return
            end
            local pass = 0
            local fail = 0
            local skip = 0
            for _, result in pairs(results) do
              if result.status == "failed" then
                fail = fail + 1
              elseif result.status == "passed" then
                pass = pass + 1
              elseif result.status == "skipped" then
                skip = skip + 1
              end
            end

            local output = "Tests completed:\n"
                .. pass
                .. " passed, "
                .. fail
                .. " failed, "
                .. skip
                .. " skipped"
            if fail > 0 then
              vim.notify(output, vim.log.levels.ERROR, { title = "Neotest" })
            else
              vim.notify(output, vim.log.levels.INFO, { title = "Neotest" })
            end
          end
          return {}
        end,
      },
    })
  end,
  keys = {
    {
      "[t",
      '<cmd>lua require("neotest").jump.prev({ status = "failed" })<CR>',
      desc = "Previous Test"
    },
    {
      "]t",
      '<cmd>lua require("neotest").jump.next({ status = "failed" })<CR>',
      desc = "Next Test"
    },
    { "<leader>tD",  '<cmd>lua require("neotest").run.run({strategy = "dap"})<CR>',                                              desc = "DAP" },
    { "<leader>ta",  '<cmd>lua require("neotest").run.attach()<CR>',                                                             desc = "Attach" },
    { "<leader>tcC", "<cmd>CoverageClear<CR>",                                                                                   desc = "Clear Coverage" },
    { "<leader>tcc", "<cmd>Coverage<CR>",                                                                                        desc = "Coverage" },
    { "<leader>tcg", '<cmd>lua require("neotest").run.run({vim.fn.getcwd(), extra_args = {"--coverprofile=coverage.out"}})<CR>', desc = "Generate Test Coverage" },
    { "<leader>tcs", "<cmd>CoverageSummary<CR>",                                                                                 desc = "Show Coverage Summary" },
    { "<leader>tct", "<cmd>CoverageToggle<CR>",                                                                                  desc = "Toggle Coverage" },
    { "<leader>td",  '<cmd>lua require("neotest").run.run(vim.fn.expand("%:p:h"))<CR>',                                          desc = "Current Directory" },
    { "<leader>te",  '<cmd>lua require("neotest").run.run(vim.fn.getcwd())<CR>',                                                 desc = "Everything" },
    { "<leader>tf",  '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<CR>',                                              desc = "Current File" },
    { "<leader>tl",  '<cmd>lua require("neotest").run.run_last()<CR>',                                                           desc = "Last" },
    { "<leader>tn",  '<cmd>lua require("neotest").run.run()<CR>',                                                                desc = "Run" },
    { "<leader>to",  '<cmd>lua require("neotest").output.open({ enter = true })<CR>',                                            desc = "Output" },
    { "<leader>ts",  '<cmd>lua require("neotest").summary.toggle()<CR>',                                                         desc = "Summary" },
    { "<leader>tx",  '<cmd>lua require("neotest").run.stop()<CR>',                                                               desc = "Stop" },
  }
}
