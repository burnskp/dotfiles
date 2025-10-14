return {
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = false,
		opts = {
			provider = "copilot",
			providers = {
				copilot = {
					model = "claude-3.7-sonnet",
				},
			},
			behaviour = {
				auto_suggestions = false,
			},
		},
		build = "make",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"folke/snacks.nvim",
			"nvim-tree/nvim-web-devicons",
			"zbirenbaum/copilot.lua",
			{
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
					},
				},
			},
			{
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
		keys = {
			{
				"<leader>aw",
				function()
					require("avante.api").ask()
				end,
				desc = "avante: ask",
				mode = { "n", "v" },
			},
			{
				"<leader>ae",
				function()
					require("avante.api").edit()
				end,
				desc = "avante: edit",
				mode = { "n", "v" },
			},
			{
				"<leader>aG",
				function()
					require("avante.api").ask({
						question = "Correct the text to standard English, but keep any code blocks inside intact.",
					})
				end,
				desc = "avante: fix grammer",
				mode = { "n", "v" },
			},
			{
				"<leader>aO",
				function()
					require("avante.api").ask({
						question = "Optimize the following code",
					})
				end,
				desc = "avante: optimize code",
				mode = { "n", "v" },
			},
			{
				"<leader>aW",
				function()
					require("avante.api").refresh()
				end,
				desc = "avante: refresh",
				mode = { "n" },
			},
			{
				"<leader>aT",
				function()
					require("avante.api").ask({ question = "Implement tests for the following code" })
				end,
				desc = "avante: add tests",
				mode = { "n" },
			},
			{
				"<leader>aX",
				function()
					require("avante.api").ask({ question = "Explain the following code" })
				end,
				desc = "avante: explain code",
				mode = { "n", "v" },
			},
		},
	},
}
