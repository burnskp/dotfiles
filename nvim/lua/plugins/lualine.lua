return {
	"nvim-lualine/lualine.nvim",
	opts = function(_, opts)
		-- This should remove the noice command output
		local line_x = {}
		for i = 2, #opts.sections.lualine_x do
			table.insert(line_x, opts.sections.lualine_x[i])
		end
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
		opts.sections.lualine_x = line_x
		opts.sections.lualine_y = { "progress" }
		opts.sections.lualine_z = { "location" }
		return opts
	end,
}
