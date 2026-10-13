vim.keymap.set("n", "<C-n>", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<C-p>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("x", "<leader>s", ":'<,'>sort i<CR>", { desc = "Sort selection" })

vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste from clipboard" })
vim.keymap.set("n", "<leader>P", '"+P', { desc = "Paste from clipboard (before)" })
vim.keymap.set("n", "<leader>y", '"+y', { desc = "Yank to clipboard" })
vim.keymap.set("x", "<leader>y", '"+y', { desc = "Yank to clipboard" })

vim.keymap.set("n", "<leader>un", function()
  vim.o.number = not vim.o.number
  vim.o.relativenumber = not vim.o.relativenumber
end, { desc = "Toggle line numbers" })

vim.keymap.set("n", "<leader>wo", "<C-w>o", { desc = "Close other windows" })
vim.keymap.set("n", "<leader>wp", "<cmd>pclose<CR>", { desc = "Close preview" })
vim.keymap.set("n", "<leader>wz", "<C-w>|<C-w>_", { desc = "Zoom window" })
vim.keymap.set("n", "ZZ", "<cmd>wqa!<CR>", { desc = "Save all and quit" })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
