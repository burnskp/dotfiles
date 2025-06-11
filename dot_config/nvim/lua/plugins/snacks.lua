local pick_chezmoi = function()
  local results = require("chezmoi.commands").list({
    args = {
      "--path-style",
      "absolute",
      "--include",
      "files",
      "--exclude",
      "externals",
    },
  })
  local items = {}

  for _, czFile in ipairs(results) do
    table.insert(items, {
      text = czFile,
      file = czFile,
    })
  end

  local opts = {
    items = items,
    confirm = function(picker, item)
      picker:close()
      require("chezmoi.commands").edit({
        targets = { item.text },
        args = { "--watch" },
      })
    end,
  }
  Snacks.picker.pick(opts)
end

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        header = [[
        ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
        ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
        ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
        ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
        ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
        ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
        ]],
        keys = {
          { icon = " ", key = "c", desc = "Config", action = pick_chezmoi },
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "e", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "n", desc = "Notes", action = ":Notes" },
          { icon = " ", key = "s", desc = "Search Notes", action = ":NotesGrep" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
      sections = {
        { section = "header" },
        { section = "keys", padding = 1 },
        { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 2 },
        { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 2 },
      },
    },
    explorer = {
      enabled = true,
      replace_netrw = true
    },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    picker = {
      enabled = true,
      sources = {
        explorer = {
          auto_close = true,
          layout = { preset = "default", preview = false },
        }
      }
    },
    scope = { enabled = true },
    words = { enabled = false },
  },
  keys = function()
    local pick_files = function()
      if vim.fn.finddir('.git', vim.fn.getcwd() .. ';') ~= '' then
        Snacks.picker.git_files()
      else
        Snacks.picker.files()
      end
    end

    local pick_grep = function()
      if vim.fn.finddir('.git', vim.fn.getcwd() .. ';') ~= '' then
        Snacks.picker.git_grep()
      else
        Snacks.picker.grep()
      end
    end

    return
    {
      { "<leader>c",  "<cmd>close<cr>",                                                                                                                          desc = "Close" },
      { "<leader>d",  function() Snacks.bufdelete() end,                                                                                                         desc = "DeleteBuffer" },
      { "<leader>gl", function() Snacks.gitbrowse() end,                                                                                                         desc = "Git Browse",            mode = { "n", "v" } },
      { "<c-/>",      function() Snacks.terminal() end,                                                                                                          desc = "Toggle Terminal" },
      { "<c-.>",      function() Snacks.scratch() end,                                                                                                           desc = "Toggle Scratch Buffer" },
      { "]]",         function() Snacks.words.jump(vim.v.count1) end,                                                                                            desc = "Next Reference",        mode = { "n", "t" } },
      { "[[",         function() Snacks.words.jump(-vim.v.count1) end,                                                                                           desc = "Prev Reference",        mode = { "n", "t" } },
      { "<leader>fb", function() Snacks.picker.buffers() end,                                                                                                    desc = "Buffers" },
      { "<leader>ff", function() pick_files() end,                                                                                                               desc = "Find Files" },
      { '<leader>f"', function() Snacks.picker.registers() end,                                                                                                  desc = "Registers" },
      { "<leader>fg", function() pick_grep() end,                                                                                                                desc = "Find Git Files" },
      { "<leader>fq", function() Snacks.picker.qflist() end,                                                                                                     desc = "Quickfix List" },
      { "<leader>fr", function() Snacks.picker.recent() end,                                                                                                     desc = "Recent Files" },
      { "<leader>fG", function() Snacks.picker.grep_buffers() end,                                                                                               desc = "Grep Open Buffers" },
      { "<leader>fd", function() Snacks.picker.diagnostics_buffer() end,                                                                                         desc = "Buffer Diagnostics" },
      { "<leader>fl", function() Snacks.picker.loclist() end,                                                                                                    desc = "Location List" },
      { "<leader>fm", function() Snacks.picker.marks() end,                                                                                                      desc = "Marks" },
      { "<leader>fu", function() Snacks.picker.undo() end,                                                                                                       desc = "Undo History" },
      { "<leader>fj", function() Snacks.picker.jumps() end,                                                                                                      desc = "Jumps" },
      { "<leader>ft", function() Snacks.explorer.open() end,                                                                                                     desc = "Explorer" },
      { "<leader>fT", function() Snacks.explorer.colorschemes() end,                                                                                             desc = "Colorschemes" },
      { "<leader>fP", function() Snacks.picker.projects() end,                                                                                                   desc = "Recent Projects" },
      { "<leader>fp", function() Snacks.picker.projects({ dev = { "/data/git/burnskp", "/data/git/iac-templates", "/data/git/projects" }, recent = false }) end, desc = "Projects" },
      { "<leader>fz", pick_chezmoi,                                                                                                                              desc = "Chezmoi" },
      { "<leader>gL", function() Snacks.picker.git_log_line() end,                                                                                               desc = "Git Log Line" },
      { "<leader>gS", function() Snacks.picker.git_stash() end,                                                                                                  desc = "Git Stash" },
      { "<leader>gr", function() Snacks.picker.git_branches() end,                                                                                               desc = "Git Branches" },
      { "<leader>gg", function() Snacks.lazygit() end,                                                                                                           desc = "Lazygit" },
      { "<leader>gd", function() Snacks.picker.git_diff() end,                                                                                                   desc = "Git Diff (Hunks)" },
      { "<leader>gf", function() Snacks.picker.git_log_file() end,                                                                                               desc = "Git Log File" },
      { "<leader>gl", function() Snacks.picker.git_log() end,                                                                                                    desc = "Git Log" },
      { "<leader>gs", function() Snacks.picker.git_status() end,                                                                                                 desc = "Git Status" },
      { "<leader>fi", function() Snacks.picker.grep() end,                                                                                                       desc = "Grep (buffer)" },
      { "<leader>lS", function() Snacks.picker.lsp_workspace_symbols() end,                                                                                      desc = "LSP Workspace Symbols" },
      { "<leader>ls", function() Snacks.picker.lsp_symbols() end,                                                                                                desc = "LSP Symbols" },
      { "<leader>lD", function() Snacks.picker.lsp_declarations() end,                                                                                           desc = "Goto Declaration" },
      { "<leader>lI", function() Snacks.picker.lsp_implementations() end,                                                                                        desc = "Goto Implementation" },
      { "<leader>ld", function() Snacks.picker.lsp_definitions() end,                                                                                            desc = "Goto Definition" },
      { "<leader>lr", function() Snacks.picker.lsp_references() end,                                                                                             nowait = true,                  desc = "References" },
      { "<leader>ly", function() Snacks.picker.lsp_type_definitions() end,                                                                                       desc = "Goto T[y]pe Definition" },
    }
  end
}
