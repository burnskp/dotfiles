-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
vim.opt.clipboard = ""
vim.opt.cursorline = false
vim.opt.mouse = ""
vim.opt.title = true
vim.opt.wrap = true

if vim.g.vscode then
	local vscode = require("vscode-neovim")
	vim.notify = vscode.notify
end
