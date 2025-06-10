local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.opt.background = "light"


local plugins = {}
if vim.g.vscode then
  plugins = { import = "vsc" }
else
  plugins = { import = "plugins" }
  require("config.options")
end

require("lazy").setup({
  lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json",
  install = {
    missing = true,
    colorscheme = { "catppuccin-latte" },
  },
  spec = { plugins },
  checker = {
    enabled = true,
    notify = false,
    frequency = 86400
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

if not vim.g.vscode then
  require("custom.jsonpath")
end
