return {
	{
		"saghen/blink.cmp",
		opts = function(_, opts)
			opts.completion.menu = {
				winblend = 0,
			}
			opts.keymap = {
				["<C-d>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide", "fallback" },

				["<C-p>"] = { "select_prev", "fallback" },
				["<C-n>"] = { "select_next", "fallback" },

				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },

				["<Tab>"] = {
					function(cmp)
						if cmp.snippet_active() then
							return cmp.accept()
						else
							return cmp.select_and_accept()
						end
					end,
					LazyVim.cmp.map({ "snippet_forward", "ai_accept" }),
					"fallback",
				},
				["<S-Tab>"] = { "snippet_backward", "fallback" },
			}
		end,
	},
}
