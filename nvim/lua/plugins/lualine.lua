return {
	"nvim-lualine/lualine.nvim",
	opts = function(_, opts)
		-- This should remove the noice command output
		local line_x = {}
		for i = 2, #opts.sections.lualine_x do
			table.insert(line_x, opts.sections.lualine_x[i])
		end
		return {
			options = {
				section_separators = "",
				component_separators = "",
			},
			sections = {
				lualine_a = {
					{
						"mode",
						fmt = function(str)
							return str:sub(1, 1)
						end,
					},
				},
				lualine_x = line_x,
				lualine_z = {},
			},
		}
	end,
}
