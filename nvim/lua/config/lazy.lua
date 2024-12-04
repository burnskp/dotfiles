local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	{ "LazyVim/LazyVim", import = "lazyvim.plugins" },
	{ import = "lazyvim.plugins.extras.coding.blink" },
	{ import = "lazyvim.plugins.extras.coding.mini-comment" },
	{ import = "lazyvim.plugins.extras.coding.mini-surround" },
	{ import = "lazyvim.plugins.extras.coding.yanky" },
	{ import = "lazyvim.plugins.extras.dap.core" },
	{ import = "lazyvim.plugins.extras.editor.dial" },
	{ import = "lazyvim.plugins.extras.editor.overseer" },
	{ import = "lazyvim.plugins.extras.lang.ansible" },
	{ import = "lazyvim.plugins.extras.lang.git" },
	{ import = "lazyvim.plugins.extras.lang.go" },
	{ import = "lazyvim.plugins.extras.lang.helm" },
	{ import = "lazyvim.plugins.extras.lang.json" },
	{ import = "lazyvim.plugins.extras.lang.markdown" },
	{ import = "lazyvim.plugins.extras.lang.python" },
	{ import = "lazyvim.plugins.extras.lang.ruby" },
	{ import = "lazyvim.plugins.extras.lang.terraform" },
	{ import = "lazyvim.plugins.extras.lang.yaml" },
	{ import = "lazyvim.plugins.extras.test.core" },
	{ import = "lazyvim.plugins.extras.ui.edgy" },
	{ import = "lazyvim.plugins.extras.ui.treesitter-context" },
	{ import = "lazyvim.plugins.extras.util.dot" },
	{ import = "lazyvim.plugins.extras.util.octo" },
	{ import = "lazyvim.plugins.extras.formatting.prettier" },
	{ import = "lazyvim.plugins.extras.editor.aerial" },
	{ import = "plugins" },
}

if not vim.env.DISABLE_GITHUB_COPILOT then
	table.insert(plugins, { import = "lazyvim.plugins.extras.ai.copilot" })
	table.insert(plugins, { import = "lazyvim.plugins.extras.ai.copilot-chat" })
end

require("lazy").setup({
	spec = plugins,
	defaults = {
		lazy = false,
		version = false,
	},
	checker = {
		enabled = true,
		frequency = 259200,
		notify = false,
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
