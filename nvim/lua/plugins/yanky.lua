-- better yank/paste
return {
	"gbprod/yanky.nvim",
	keys = {
		{
			"<leader>fp",
			function()
				if LazyVim.pick.picker.name == "telescope" then
					require("telescope").extensions.yank_history.yank_history({})
				else
					vim.cmd([[YankyRingHistory]])
				end
			end,
			desc = "Open Yank History",
		},
	},
}
