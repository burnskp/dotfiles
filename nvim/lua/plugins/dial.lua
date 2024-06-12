return {
	"monaqa/dial.nvim",
	config = function()
		local augend = require("dial.augend")
		require("dial.config").augends:register_group({
			default = {
				augend.integer.alias.decimal_int,
				augend.integer.alias.hex,
				augend.date.alias["%Y/%m/%d"],
				augend.constant.new({
					elements = { "and", "or" },
					word = true,
					cyclic = true,
				}),
				augend.constant.new({
					elements = { "&&", "||" },
					word = false,
					cyclic = true,
				}),
				augend.constant.new({
					elements = { "else", "elif" },
					word = true,
					cyclic = true,
				}),
				augend.constant.new({
					elements = { "on", "off" },
					word = true,
					cyclic = true,
				}),
				augend.constant.new({
					elements = { "yes", "no" },
					word = true,
					cyclic = true,
				}),
				augend.constant.new({
					elements = { "first", "last" },
					word = true,
					cyclic = true,
				}),
				augend.constant.alias.bool,
				augend.semver.alias.semver,
			},
			visual = {
				augend.integer.alias.decimal_int,
				augend.integer.alias.hex,
				augend.date.alias["%Y/%m/%d"],
				augend.constant.alias.alpha,
				augend.constant.alias.Alpha,
				augend.semver.alias.semver,
				augend.constant.new({
					elements = { "-", "_" },
					word = false,
					cyclic = true,
				}),
			},
		})
	end,
	keys = {
		{
			"<C-a>",
			function()
				return require("dial.map").inc_normal()
			end,
			expr = true,
			desc = "Increment",
			mode = { "n", "v" },
		},
		{
			"<C-x>",
			function()
				return require("dial.map").dec_normal()
			end,
			expr = true,
			desc = "Decrement",
			mode = { "n", "v" },
		},
		{
			"g<C-a>",
			function()
				return require("dial.map").inc_gnormal()
			end,
			expr = true,
			desc = "Increment",
			mode = { "n", "v" },
		},
		{
			"g<C-x>",
			function()
				return require("dial.map").dev_gnormal()
			end,
			expr = true,
			desc = "Decrement",
			mode = { "n", "v" },
		},
	},
}
