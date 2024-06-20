local Util = require("lazyvim.util")
return {
	"telescope.nvim",
	opts = {
		defaults = {
			layout_strategy = "vertical",
			layout_config = {
				preview_cutoff = 10,
			},
		},
	},
}
