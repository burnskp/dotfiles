return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "super-tab",
      ["<C-k>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
    },
  },
}
