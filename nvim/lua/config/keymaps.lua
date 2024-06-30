-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.api.nvim_set_keymap

-- Remove gj/gk lazyvim mapping override
vim.keymap.del({ "n", "x" }, "j")
vim.keymap.del({ "n", "x" }, "k")

-- Remove Move Line Up/Down mappings
vim.keymap.del({ "i", "n", "x" }, "<M-j>")
vim.keymap.del({ "i", "n", "x" }, "<M-k>")

keymap("n", "<C-n>", "<cmd>bn<cr>", { desc = "Next Buffer" })
keymap("n", "<leader>ae", "<cmd>Copilot enable<cr>", { desc = "Enable Copilot" })
keymap("n", "<leader>aD", "<cmd>Copilot disable<cr>", { desc = "Disable Copilot" })
keymap("n", "<C-p>", "<cmd>bp<cr>", { desc = "Previous Buffer" })
keymap("n", "<leader>P", '"+P', { desc = "Paste from System Clipboard" })
keymap("n", "<leader>p", '"+p', { desc = "Paste from System Clipboard" })
keymap("n", "<leader>y", '"+y', { desc = "Yank to System Clipboard" })
keymap("v", "<leader>y", '"+y', { desc = "Yank to System Clipboard" })
