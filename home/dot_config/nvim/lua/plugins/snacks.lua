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
        header = "",
        keys = {
          { icon = " ", key = "c", desc = "Config", action = pick_chezmoi },
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "e", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "n", desc = "Notes", action = ":lua Snacks.dashboard.pick('files', {dirs = {'~/.local/share/obsidian/main'}})" },
          { icon = " ", key = "s", desc = "Search Notes", action = ":ObsidianSearch" },
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
      { "<c-.>",      function() Snacks.scratch() end,                                                                                                           desc = "Toggle Scratch Buffer" },
      { "<c-/>",      function() Snacks.terminal() end,                                                                                                          desc = "Toggle Terminal" },
      { "<leader>d",  function() if vim.fn.winnr('$') > 1 then vim.cmd('close') else Snacks.bufdelete() end end,                                                 desc = "DeleteBuffer" },
      { "<leader>fb", function() Snacks.picker.buffers() end,                                                                                                    desc = "Buffers" },
      { "<leader>fd", function() Snacks.picker.diagnostics_buffer() end,                                                                                         desc = "Buffer Diagnostics" },
      { "<leader>ff", function() pick_files() end,                                                                                                               desc = "Find Files" },
      { "<leader>fg", function() pick_grep() end,                                                                                                                desc = "Find Git Files" },
      { "<leader>fG", function() Snacks.picker.grep_buffers() end,                                                                                               desc = "Grep Open Buffers" },
      { "<leader>fi", function() Snacks.picker.grep() end,                                                                                                       desc = "Grep (buffer)" },
      { "<leader>fj", function() Snacks.picker.jumps() end,                                                                                                      desc = "Jumps" },
      { "<leader>fl", function() Snacks.picker.loclist() end,                                                                                                    desc = "Location List" },
      { "<leader>fm", function() Snacks.picker.marks() end,                                                                                                      desc = "Marks" },
      { "<leader>fP", function() Snacks.picker.projects() end,                                                                                                   desc = "Recent Projects" },
      { "<leader>fp", function() Snacks.picker.projects({ dev = { "/data/git/burnskp", "/data/git/iac-templates", "/data/git/projects" }, recent = false }) end, desc = "Projects" },
      { "<leader>fq", function() Snacks.picker.qflist() end,                                                                                                     desc = "Quickfix List" },
      { "<leader>fr", function() Snacks.picker.recent() end,                                                                                                     desc = "Recent Files" },
      { "<leader>fT", function() Snacks.explorer.colorschemes() end,                                                                                             desc = "Colorschemes" },
      { "<leader>ft", function() Snacks.explorer.open() end,                                                                                                     desc = "Explorer" },
      { "<leader>fu", function() Snacks.picker.undo() end,                                                                                                       desc = "Undo History" },
      { "<leader>fz", pick_chezmoi,                                                                                                                              desc = "Chezmoi" },
      { "<leader>gd", function() Snacks.picker.git_diff() end,                                                                                                   desc = "Git Diff (Hunks)" },
      { "<leader>gf", function() Snacks.picker.git_log_file() end,                                                                                               desc = "Git Log File" },
      { "<leader>gg", function() Snacks.lazygit() end,                                                                                                           desc = "Lazygit" },
      { "<leader>gl", function() Snacks.gitbrowse() end,                                                                                                         desc = "Git Browse",           mode = { "n", "v" } },
      { "<leader>gl", function() Snacks.picker.git_log() end,                                                                                                    desc = "Git Log" },
      { "<leader>gL", function() Snacks.picker.git_log_line() end,                                                                                               desc = "Git Log Line" },
      { "<leader>gr", function() Snacks.picker.git_branches() end,                                                                                               desc = "Git Branches" },
      { "<leader>gS", function() Snacks.picker.git_stash() end,                                                                                                  desc = "Git Stash" },
      { "<leader>gs", function() Snacks.picker.git_status() end,                                                                                                 desc = "Git Status" },
      { "[[",         function() Snacks.words.jump(-vim.v.count1) end,                                                                                           desc = "Prev Reference",       mode = { "n", "t" } },
      { "]]",         function() Snacks.words.jump(vim.v.count1) end,                                                                                            desc = "Next Reference",       mode = { "n", "t" } },
      { '<leader>f"', function() Snacks.picker.registers() end,                                                                                                  desc = "Registers" },
    }
  end
}
