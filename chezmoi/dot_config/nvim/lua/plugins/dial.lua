return {
  "monaqa/dial.nvim",
  -- stylua: ignore
  keys = {
    { "<C-a>", function() require("dial.map").manipulate("increment", "normal") end, desc = "Increment" },
    { "<C-a>", function() require("dial.map").manipulate("increment", "visual") end, desc = "Increment", mode = {"x"} },
    { "<C-x>", function() require("dial.map").manipulate("decrement", "normal") end, desc = "Decrement" },
    { "<C-x>", function() require("dial.map").manipulate("decrement", "visual") end, desc = "Decrement", mode = {"x"} },
  },
  config = function()
    local augend = require("dial.augend")
    require("dial.config").augends:register_group({
      default = {
        augend.integer.alias.decimal_int,
        augend.integer.alias.hex,
        augend.constant.new({ elements = { "and", "or" }, word = true, cyclic = true }),
        augend.constant.new({ elements = { "enabled", "disabled" }, word = true, cyclic = true }),
        augend.constant.new({ elements = { "on", "off" }, word = true, cyclic = true }),
        augend.constant.new({ elements = { "next", "prev" }, word = true, cyclic = true }),
        augend.constant.new({ elements = { "yes", "no" }, word = true, cyclic = true }),
        augend.constant.alias.bool,
        augend.semver.alias.semver,
      },
      visual = {
        augend.integer.alias.decimal_int,
        augend.integer.alias.hex,
        augend.constant.alias.alpha,
        augend.constant.alias.Alpha,
        augend.semver.alias.semver,
        augend.constant.new({ elements = { "-", "_" }, word = true, cyclic = true }),
      },
    })
  end,
}
