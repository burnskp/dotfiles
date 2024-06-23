-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.api.nvim_set_keymap

if vim.g.vscode then
	local function action(cmd)
		return string.format("<cmd>lua require('vscode-neovim').action('%s')<CR>", cmd)
	end

	keymap("n", "<leader>ai", action("workbench.action.openQuickChat.copilot"), { silent = true })
	keymap("n", "<leader>at", action("github.copilot.toggleCopilot"), { silent = true })
	keymap("n", "<leader>D", action("editor.action.revealDefinitionAside"), { silent = true })
	keymap("n", "<leader>F", action("editor.action.formatDocument"), { silent = true })
	keymap("n", "<leader>P", '"+P', { silent = true })
	keymap("n", "<leader>d", action("workbench.action.closeWindow"), { silent = true })
	keymap("n", "<leader>D", action("editor.action.showDefinitionPreviewHover"), { silent = true })
	keymap("n", "<leader>e", action("problems.action.open"), { silent = true })
	keymap("n", "<leader>ff", action("workbench.action.quickOpen"), { silent = true })
	keymap("n", "<leader>fg", action("workbench.action.findInFiles"), { silent = true })
	keymap("n", "<leader>fp", action("projectManager.listProjects"), { silent = true })
	keymap("n", "<leader>fr", action("references-view.findReferences"), { silent = true })
	keymap("n", "<leader>gb", action("gitlens.toggleFileBlame"), { silent = true })
	keymap("n", "<leader>gd", action("editor.action.revealDefinition"), { silent = true })
	keymap("n", "<leader>gi", action("editor.action.goToImplementation"), { silent = true })
	keymap("n", "<leader>gl", action("extension.copyGitHubLinkToClipboard"), { silent = true })
	keymap("n", "<leader>gr", action("editor.action.goToReferences"), { silent = true })
	keymap("n", "<leader>gs", action("workbench.action.gotoSymbols"), { silent = true })
	keymap("n", "<leader>gt", action("editor.action.goToTypeDefinition"), { silent = true })
	keymap("n", "<leader>h", action("editor.action.showHover"), { silent = true })
	keymap("n", "<leader>k", action("extension.dash.specific"), { silent = true })
	keymap("n", "<leader>ls", action("workbench.action.showAllSymbols"), { silent = true })
	keymap("n", "<leader>p", '"+p', { silent = true })
	keymap("n", "<leader>rf", action("editor.action.refactor"), { silent = true })
	keymap("n", "<leader>rn", action("editor.action.rename"), { silent = true })
	keymap("n", "<leader>y", '"+y', { silent = true })
	keymap("n", "[D", action("editor.action.marker.prevInFiles"), { silent = true })
	keymap("n", "[d", action("editor.action.marker.prev"), { silent = true })
	keymap("n", "]D", action("editor.action.marker.nextInFiles"), { silent = true })
	keymap("n", "]d", action("editor.action.marker.next"), { silent = true })
	keymap("n", "gc", "<Plug>VSCodeCommentary", { silent = true })
	keymap("n", "gcc", "<Plug>VSCodeCommentaryLine", { silent = true })
	keymap("o", "gc", "<Plug>VSCodeCommentary", { silent = true })
	keymap("v", "<leader>y", '"+y', { silent = true })
	keymap("v", "gc", "<Plug>VSCodeCommentary", { silent = true })
	keymap("x", "gc", "<Plug>VSCodeCommentary", { silent = true })
else
	-- Remove gj/gk lazyvim mapping override
	vim.keymap.del({ "n", "x" }, "j")
	vim.keymap.del({ "n", "x" }, "k")

	-- Remove Move Line Up/Down mappings
	vim.keymap.del({ "i", "n", "x" }, "<M-j>")
	vim.keymap.del({ "i", "n", "x" }, "<M-k>")

	keymap("n", "<C-n>", "<cmd>bn<cr>", { desc = "Next Buffer" })
	keymap("n", "<leader>ae", "<cmd>Copilot enable<cr>", { desc = "Enable Copilot" })
	keymap("n", "<leader>aD", "<cmd>Copilot disable<cr>", { desc = "Disable Copilot" })
	keymap("n", "<C-p>", "<cmd>bp<cr>", { desc = "Previous Buffer" })
	keymap("n", "<leader>P", '"+P', { desc = "Paste from System Clipboard" })
	keymap("n", "<leader>p", '"+p', { desc = "Paste from System Clipboard" })
	keymap("n", "<leader>y", '"+y', { desc = "Yank to System Clipboard" })
	keymap("v", "<leader>y", '"+y', { desc = "Yank to System Clipboard" })
end
