return {
	"LazyVim/LazyVim",
	dependencies = { { "tjdevries/colorbuddy.nvim", tag = "v1.0.0" }, "burnskp/cobalt2.nvim" },
	opts = {
		colorscheme = function()
			require("colorbuddy").colorscheme("cobalt2")
		end,
	},
}
