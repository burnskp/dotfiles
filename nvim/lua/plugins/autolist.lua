return {
	{
		"gaoDean/autolist.nvim",
		ft = {
			"markdown",
			"text",
			"tex",
			"plaintex",
			"norg",
		},
		config = function()
			require("autolist").setup()
		end,
		keys = {
			{ "<tab>", "<cmd>AutolistTab<cr>", mode = "i" },
			{ "<s-tab>", "<cmd>AutolistShiftTab<cr>", mode = "i" },
			{ "o", "o<cmd>AutolistNewBullet<cr>", mode = "n" },
			{ "O", "O<cmd>AutolistNewBulletBefore<cr>", mode = "n" },
			{ "<CR>", "<cmd>AutolistToggleCheckbox<cr>", mode = "n" },
			{ "<C-r>", "<cmd>AutolistRecalculate<cr>", mode = "n" },
			{ ">>", ">><cmd>AutolistRecalculate<cr>", mode = "v" },
			{ "<<", "<<<cmd>AutolistRecalculate<cr>", mode = "v" },
		},
	},
	{
		"echasnovski/mini.pairs",
		-- Remaps <CR> to allow autolist to work in text/markdown files while
		-- allowing mini.pairs to continue to work as expected on other files.
		config = function(_, opts)
			LazyVim.mini.pairs(opts)
			local disabled_filetypes = {
				markdown = true,
				text = true,
				tex = true,
				plaintex = true,
				norg = true,
			}
			if disabled_filetypes[vim.bo.filetype] then
				vim.keymap.set("i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>", { noremap = true })
			end
		end,
	},
}
