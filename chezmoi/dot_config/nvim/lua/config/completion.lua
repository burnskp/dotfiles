vim.opt.completeopt = { "menu", "menuone", "noselect", "popup" }

-- Auto-trigger built-in path completion (<C-x><C-f>) when / or ~ is typed
vim.api.nvim_create_autocmd("TextChangedI", {
  callback = function()
    local col = vim.fn.col(".") - 1
    if col == 0 then return end
    local line = vim.fn.getline(".")
    local char = line:sub(col, col)
    if (char == "/" or char == "~") and vim.fn.pumvisible() == 0 then
      vim.fn.feedkeys(vim.keycode("<C-x><C-f>"), "n")
    end
  end,
})
