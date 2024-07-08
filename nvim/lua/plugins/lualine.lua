return {
	"nvim-lualine/lualine.nvim",
	opts = function(_, opts)
		-- This should remove the noice command output
		table.remove(opts.sections.lualine_x, 1)
		opts.options.section_separators = ""
		opts.options.component_separators = ""
		opts.sections.lualine_a = {
			{
				"mode",
				fmt = function(str)
					return str:sub(1, 1)
				end,
			},
		}
		opts.sections.lualine_y = { "filetype" }
		opts.sections.lualine_z = { "progress", "location" }
		return opts
	end,
}
