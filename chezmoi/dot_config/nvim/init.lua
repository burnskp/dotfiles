require("config.options")
require("config.keymaps")
require("config.ui")
require("config.completion")

local pack = require("config.pack")

pack.bootstrap()

require("config.diagnostics")
require("config.lsp")

pack.configure()
