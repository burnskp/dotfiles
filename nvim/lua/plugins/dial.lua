return {
	"monaqa/dial.nvim",
	opts = function(_, opts)
		local augend = require("dial.augend")
		opts.groups.go = opts.groups.go or {}

		local and_or = augend.constant.new({ elements = { "and", "or" } })
		local on_off = augend.constant.new({ elements = { "on", "off" } })
		local yes_no = augend.constant.new({ elements = { "yes", "no" } })
		local else_elseif = augend.constant.new({ elements = { "else", "elseif" } })
		local else_elif = augend.constant.new({ elements = { "else", "elif" } })
		local else_else_if = augend.constant.new({ elements = { "else", "else if" } })

		table.insert(opts.groups.default, and_or)
		table.insert(opts.groups.default, on_off)
		table.insert(opts.groups.default, yes_no)
		table.insert(opts.groups.lua, else_elseif)
		table.insert(opts.groups.python, else_elif)
		table.insert(opts.groups.go, else_else_if)
	end,
}
