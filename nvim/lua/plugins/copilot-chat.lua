if vim.env.DISABLE_GITHUB_COPILOT then
	return {}
else
	return {
		"CopilotC-Nvim/CopilotChat.nvim",
		opts = {
			mappings = {
				reset = {
					normal = "<C-r>",
					insert = "<C-r>",
				},
			},
		},
		keys = {
			{
				"<leader>aa",
				function()
					return require("CopilotChat").open({
						selection = function()
							return nil
						end,
					})
				end,
				desc = "Toggle (CopilotChat)",
				mode = { "n" },
			},
			{
				"<leader>aa",
				function()
					return require("CopilotChat").open({
						selection = function(source)
							return require("CopilotChat.select").visual(source) or nil
						end,
					})
				end,
				desc = "Toggle (CopilotChat)",
				mode = { "v" },
			},
			{
				"<leader>ad",
				"<cmd>CopilotChatDocs<cr>",
				desc = "Document Code",
				mode = { "n", "v" },
			},
			{
				"<leader>af",
				"<cmd>CopilotChatFix<cr>",
				desc = "Fix Code",
				mode = { "n", "v" },
			},
			{
				"<leader>ao",
				"<cmd>CopilotChatOptimize<cr>",
				desc = "Optimize Code",
				mode = { "n", "v" },
			},
			{
				"<leader>at",
				"<cmd>CopilotChatTests<cr>",
				desc = "Add Tests to Code",
				mode = { "n", "v" },
			},
			{
				"<leader>as",
				function()
					return require("CopilotChat").toggle()
				end,
				desc = "Toggle (CopilotChat)",
				mode = { "n", "v" },
			},
		},
	}
end
