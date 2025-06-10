return {
  'saghen/blink.cmp',
  dependencies = {
    'Kaiser-Yang/blink-cmp-avante',
    'fang2hou/blink-copilot',
    'rafamadriz/friendly-snippets',
  },
  version = '1.*',
  opts = {
    keymap = {
      preset = 'super-tab',
      ['<C-k>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-s>'] = { 'show_signature', 'hide_signature', 'fallback' },

    },
    completion = { documentation = { auto_show = false } },
    signature = { enabled = true },
    sources = {
      default = { 'lazydev', 'copilot', 'avante', 'snippets', 'lsp', 'path', 'buffer' },
      providers = {
        avante = {
          module = 'blink-cmp-avante',
          name = 'Avante',
          opts = {
          }
        },
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 100,
          async = true,
        },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
      },
    },
  },
}
