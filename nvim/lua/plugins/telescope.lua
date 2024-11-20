return {
	{
		"telescope.nvim",
		opts = {
			extensions = {
				undo = {
					use_delta = false,
				},
			},
			defaults = {
				layout_strategy = "vertical",
				layout_config = {
					preview_cutoff = 10,
				},
			},
		},
	},
	{
		"debugloop/telescope-undo.nvim",
		dependencies = { -- note how they're inverted to above example
			{
				"nvim-telescope/telescope.nvim",
				dependencies = { "nvim-lua/plenary.nvim" },
			},
		},
		config = function()
			require("telescope").load_extension("undo")
		end,
		keys = {
			{ "<leader>fu", "<cmd>Telescope undo<cr>", desc = "Undo" },
		},
	},
	{
		"nvim-telescope/telescope-frecency.nvim",
		dependencies = { -- note how they're inverted to above example
			{
				"nvim-telescope/telescope.nvim",
				dependencies = { "nvim-lua/plenary.nvim" },
			},
		},
		config = function()
			require("telescope").load_extension("frecency")
		end,
		keys = {
			{ "<leader>sf", "<cmd>Telescope frecency<cr>", desc = "Frecuency" },
		},
	},
}
