return {
	{
		"williamboman/mason.nvim",
		opts = { ensure_installed = { "golangci-lint" } },
	},
	{
		"mfussenegger/nvim-lint",
		opts = {
			linters_by_ft = {
				ansible = { "ansible_lint" },
				commit = { "commitlint" },
				go = { "golangcilint" },
				zsh = { "zsh" },
			},
		},
	},
}
