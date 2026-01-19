vim.opt_local.number = false
vim.opt_local.relativenumber = false
vim.opt_local.signcolumn = "no"
vim.diagnostic.enable(false, { bufnr = 0 })
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.conceallevel = 2
vim.opt_local.concealcursor = "nc"
vim.opt_local.foldenable = false
vim.opt_local.spell = true
vim.opt_local.textwidth = 80

vim.schedule(function()
  pcall(function() require('lualine').hide() end)
  vim.opt.laststatus = 0
  vim.api.nvim_set_keymap('n', '<Esc>', '<cmd>q<CR>', {noremap = true, silent = true})
end)
