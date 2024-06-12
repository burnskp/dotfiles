return {
	"LazyVim/LazyVim",
	cond = function()
		return not vim.g.vscode
	end,

	dependencies = { { "tjdevries/colorbuddy.nvim", tag = "v1.0.0" }, "lalitmee/cobalt2.nvim" },
	opts = {
		colorscheme = function()
			require("colorbuddy").colorscheme("cobalt2")
		end,
	},
}
