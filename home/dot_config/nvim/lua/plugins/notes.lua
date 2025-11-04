return {
  {
    "burnskp/notes.nvim",
    opts = {
      git = {
        auto_commit = true,
        auto_push = true,
      },
    },
    cmd = {
      "CreateNote",
      "Notes",
      "NotesAll",
      "NotesAllGrep",
      "NotesGrep",
      "LastNote",
      "ProjectNote",
      "ProjectNotes",
      "ProjectNotesGrep",
    },
    keys = {
      { "<leader>na", "<cmd>NotesAllGrep float<CR>", desc = "Grep All Notes (Float)" },
      { "<leader>nA", "<cmd>NotesAllGrep <CR>", desc = "Grep All Notes" },
      { "<leader>nf", "<cmd>Notes float<CR>", desc = "Find Notes (Float)" },
      { "<leader>nF", "<cmd>Notes<CR>", desc = "Find Notes" },
      { "<leader>ng", "<cmd>NotesGrep float<CR>", desc = "Grep Notes (Float)" },
      { "<leader>nG", "<cmd>NotesGrep<CR>", desc = "Grep Notes" },
      { "<leader>nn", "<cmd>LastNote float<CR>", desc = "Open Last Note (Float)" },
      { "<leader>np", "<cmd>ProjectNotes float<CR>", desc = "Find Project Notes (Float)" },
      { "<leader>nP", "<cmd>ProjectNotes<CR>", desc = "Find Project Notes" },
      { "<leader>ns", "<cmd>ProjectNote scratch float<CR>", desc = "Project Note - Scratch (Float)" },
      { "<leader>nS", "<cmd>ProjectNote scratch<CR>", desc = "Grep Project NotNote - Scratch" },
      { "<leader>nt", "<cmd>ProjectNote todo float<CR>", desc = "Project Note - Todo (Float)" },
      { "<leader>nT", "<cmd>ProjectNote todo<CR>", desc = "Grep Project NotNote - Todo" },
    },
  },
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      local keys = {
        { icon = " ", key = "s", desc = "Search Notes", action = ":NotesGrep" },
        { icon = " ", key = "n", desc = "Notes", action = ":Notes" },
        { icon = " ", key = "e", desc = "New File", action = ":ene | startinsert" },
      }

      for _, key in ipairs(keys) do
        local config_index = 2
        for i = #opts.dashboard.preset.keys, 1, -1 do
          if opts.dashboard.preset.keys[i].key == key.key then
            table.remove(opts.dashboard.preset.keys, i)
            break
          end
        end
        table.insert(opts.dashboard.preset.keys, config_index, key)
        config_index = config_index + 1
      end
    end,
  },
}
