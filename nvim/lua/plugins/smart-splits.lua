return {
	"mrjones2014/smart-splits.nvim",
	keys = {
		{
			"<A-h>",
			function()
				require("smart-splits").resize_left()
			end,
			desc = "Resize Left",
			mode = { "n" },
		},
		{
			"<A-j>",
			function()
				require("smart-splits").resize_down()
			end,
			desc = "Resize Down",
			mode = { "n" },
		},
		{
			"<A-k>",
			function()
				require("smart-splits").resize_up()
			end,
			desc = "Resize Up",
			mode = { "n" },
		},
		{
			"<A-l>",
			function()
				require("smart-splits").resize_right()
			end,
			desc = "Resize Right",
			mode = { "n" },
		},
		{
			"<C-h>",
			function()
				require("smart-splits").move_cursor_left()
			end,
			desc = "Move Cursor Left",
			mode = { "n" },
		},
		{
			"<C-j>",
			function()
				require("smart-splits").move_cursor_down()
			end,
			desc = "Move Cursor Down",
			mode = { "n" },
		},
		{
			"<C-k>",
			function()
				require("smart-splits").move_cursor_up()
			end,
			desc = "Move Cursor Up",
			mode = { "n" },
		},
		{
			"<C-l>",
			function()
				require("smart-splits").move_cursor_right()
			end,
			desc = "Move Cursor Right",
			mode = { "n" },
		},
		{
			"<C-\\>",
			function()
				require("smart-splits").move_cursor_previous()
			end,
			desc = "Move Cursor Previous",
			mode = { "n" },
		},
		{
			"<leader><leader>h",
			function()
				require("smart-splits").swap_buf_left()
			end,
			desc = "Swap Buf Left",
			mode = { "n" },
		},
		{
			"<leader><leader>j",
			function()
				require("smart-splits").swap_buf_down()
			end,
			desc = "Swap Buf Down",
			mode = { "n" },
		},
		{
			"<leader><leader>k",
			function()
				require("smart-splits").swap_buf_up()
			end,
			desc = "Swap Buf Up",
			mode = { "n" },
		},
		{
			"<leader><leader>l",
			function()
				require("smart-splits").swap_buf_right()
			end,
			desc = "Swap Buf Right",
			mode = { "n" },
		},
	},
}
