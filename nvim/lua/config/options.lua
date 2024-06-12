-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
vim.g.mapleader = " "
vim.o.clipboard = ""
vim.o.cursorline = false
vim.o.grepprg = "rg"
vim.o.linebreak = true
vim.o.mouse = ""
vim.o.title = true
vim.o.wrap = true

if vim.g.vscode then
	local vscode = require("vscode-neovim")
	vim.notify = vscode.notify
end
