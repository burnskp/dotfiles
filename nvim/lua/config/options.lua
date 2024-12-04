-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
vim.opt.clipboard = ""
vim.opt.cursorline = false
vim.opt.mouse = ""
vim.opt.textwidth = 80
vim.opt.title = true
vim.opt.wrap = true
vim.opt.title = true
vim.opt.titlestring = "n:%t"

vim.filetype.add({
	extension = {
		lic = "ruby",
	},
})

-- Disable unused providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
