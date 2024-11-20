return {
	"hrsh7th/nvim-cmp",
	---@param opts cmp.ConfigSchema
	opts = function(_, opts)
		local cmp = require("cmp")

		opts.mapping = vim.tbl_extend("force", opts.mapping, {
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp and cmp.visible() then
					cmp.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = false,
					})
				elseif vim.snippet.active({ direction = 1 }) then
					vim.snippet.jump(1)
				else
					fallback()
				end
			end, { "i", "s" }),
			["<C-n>"] = cmp.mapping(function(fallback)
				if cmp and cmp.visible() then
					cmp.select_next_item()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<C-p>"] = cmp.mapping(function(fallback)
				if cmp and cmp.visible() then
					cmp.select_prev_item()
				else
					fallback()
				end
			end, { "i", "s" }),
		})
		opts.mapping["<CR>"] = nil
		opts.mapping["<C-Space>"] = nil
	end,
}
