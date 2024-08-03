return {
	"nvim-neotest/neotest",
	dependencies = { "nvim-neotest/nvim-nio" },
	opts = {},
	keys = {
		{
			"<leader>tT",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "Run File",
		},
		{
			"<leader>tt",
			function()
				require("neotest").run.run(vim.uv.cwd())
			end,
			desc = "Run All Test Files",
		},
		{
			"<leader>to",
			function()
				require("neotest").output.open({ enter = true, auto_close = true, last_run = true })
			end,
			desc = "Show Output",
		},
	},
}
