return {
	{
		"folke/which-key.nvim",
		optional = true,
		opts = function(_, opts)
			table.insert(opts.spec, { "<leader>n", group = "+obsidian" })
		end,
	},
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		lazy = true,
		event = {
			"BufReadPre " .. vim.fn.expand("~/Library/Mobile Documents/iCloud~md~obsidian/Documents/main"),
			"BufNewFile " .. vim.fn.expand("~/Library/Mobile Documents/iCloud~md~obsidian/Documents/main"),
		},
		cmd = {
			"ObsidianOpen",
			"ObsidianQuickSwitch",
			"ObsidianNew",
			"ObsidianSearch",
			"ObsidianTemplate",
			"ObsidianToday",
			"ObsidianTomorrow",
			"ObsidianYesterday",
		},
		dependencies = {
			"hrsh7th/nvim-cmp",
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
		opts = {
			ui = { enable = false },
			workspaces = {
				{
					name = "main",
					path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/main",
				},
			},
			daily_notes = {
				folder = "daily/",
				template = "daily.md",
			},
			new_notes_location = "current_dir",
			use_advanced_uri = true,
			note_id_func = function(title)
				return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
			end,
			substitutions = {
				time24 = function()
					return os.date("%H:%M:%S")
				end,
				time12 = function()
					-- Conversion to 12-hour format with AM/PM
					local hour = tonumber(os.date("%H"))
					local ampm = hour >= 12 and "PM" or "AM"
					hour = hour % 12
					hour = hour == 0 and 12 or hour
					return string.format("%02d:%s %s", hour, os.date("%M:%S"), ampm)
				end,
				year = function()
					return os.date("%Y", os.time())
				end,
				month = function()
					return os.date("%B", os.time())
				end,
				yesterday = function()
					return os.date("%Y-%m-%d", os.time() - 86400)
				end,
				nextday = function()
					return os.date("%Y-%m-%d", os.time() + 86400)
				end,
				hdate = function()
					return os.date("%A, %B %d, %Y")
				end,
				rfc3339 = function()
					return os.date("!%Y-%m-%dT%H:%M:%SZ")
				end,
				week = function()
					return os.date("%V", os.time())
				end,
				isoweek = function()
					return os.date("%G-W%V", os.time())
				end,
				isoprevweek = function()
					local adjustment = -7 * 24 * 60 * 60 -- One week in seconds
					return os.date("%G-W%V", os.time() + adjustment)
				end,
				isonextweek = function()
					local adjustment = 7 * 24 * 60 * 60 -- One week in seconds
					return os.date("%G-W%V", os.time() + adjustment)
				end,
				day_of_month = function()
					return os.date("%d", os.time())
				end,
				month_numeric = function()
					return os.date("%m", os.time())
				end,
				weekday = function()
					return os.date("%A", os.time())
				end,
			},
			follow_url_func = function(url)
				vim.fn.jobstart({ "open", url }) -- Mac OS
			end,
			mappings = {
				-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
				["gf"] = {
					action = function()
						return require("obsidian").util.gf_passthrough()
					end,
					opts = { noremap = false, expr = true, buffer = true },
				},
				-- Smart action depending on context, either follow link or toggle checkbox.
				["<cr>"] = {
					action = function()
						return require("obsidian").util.smart_action()
					end,
					opts = { buffer = true, expr = true },
				},
				["<leader>nb"] = {
					action = function()
						vim.cmd("ObsidianBacklinks")
					end,
					opts = { buffer = true, expr = true, desc = "Link Backlinks" },
				},
				["<leader>nc"] = {
					action = function()
						return require("obsidian").util.toggle_checkbox()
					end,
					opts = { buffer = true, desc = "Toggle Checkbox" },
				},
				["<leader>ni"] = {
					action = function()
						return "<cmd>ObsidianPasteImg<cr>"
					end,
					opts = { buffer = true, expr = true, desc = "Paste Image" },
				},
				["<leader>nL"] = {
					action = function()
						return "<cmd>ObsidianLinks<cr>"
					end,
					opts = { buffer = true, expr = true, desc = "List Links" },
				},
				["<leader>nn"] = {
					action = function()
						return "<cmd>ObsidianNew<cr>"
					end,
					opts = { buffer = true, expr = true, desc = "New Note and Link" },
				},
				["<leader>nr"] = {
					action = function()
						return "<cmd>ObsidianRename<cr>"
					end,
					opts = { buffer = true, expr = true, desc = "Rename Note" },
				},
			},
		},
		config = function(_, opts)
			vim.keymap.set(
				"v",
				"<leader>ne",
				"<cmd>ObsidianExtractNote<cr>",
				{ noremap = true, silent = true, desc = "Extract Note" }
			)
			vim.keymap.set(
				"v",
				"<leader>nl",
				"<cmd>ObsidianLink<cr>",
				{ noremap = true, silent = true, desc = "Link Note" }
			)
			require("obsidian").setup(opts)
		end,
		keys = {
			{ "<leader>nD", "<cmd>ObsidianDailies<cr>", desc = "Select Daily Note" },
			{ "<leader>nd", "<cmd>ObsidianToday<cr>", desc = "Open Daily Note" },
			{ "<leader>nn", "<cmd>ObsidianNew<cr>", desc = "Create Note" },
			{ "<leader>ns", "<cmd>ObsidianSearch<cr>", desc = "Search" },
			{ "<leader>nt", "<cmd>ObsidianTemplate<cr>", desc = "Template Note" },
		},
	},
}
