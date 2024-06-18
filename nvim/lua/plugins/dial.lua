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
			lua = {
				augend.constant.new({
					elements = { "else", "elseif" },
					word = true,
					cyclic = true,
				}),
			},
			python = {
				augend.constant.new({
					elements = { "else", "elif" },
					word = true,
					cyclic = true,
				}),
			},
			go = {
				augend.constant.new({
					elements = { "else", "else if" },
					word = true,
					cyclic = true,
				}),
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
}
