return {
  "mason-org/mason.nvim",
  opts = function(_, opts)
    vim.list_extend(opts.ensure_installed, {
      "fixjson",
    })
  end,
  config = function(_, opts)
    require("mason").setup(opts)
    local mr = require("mason-registry")
    mr:on("package:install:success", function()
      vim.defer_fn(function()
        -- trigger FileType event to possibly load this newly installed LSP server
        require("lazy.core.handler.event").trigger({
          event = "FileType",
          buf = vim.api.nvim_get_current_buf(),
        })
      end, 100)
    end)

    mr.refresh(function()
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end)

    local registry_status_ok, mason_registry = pcall(require, "mason-registry")
    if not registry_status_ok then
      return
    end

    mason_registry.refresh(function()
      local mdformat = mason_registry.get_package("mdformat")
      local mdformat_extensions = {
        "mdformat-beautysh",
        "mdformat-black",
        "mdformat-config",
        "mdformat-footnote",
        "mdformat-frontmatter",
        "mdformat-mkdocs",
        "mdformat-simple-breaks",
        "mdformat-web",
        "mdformat-wikilink",
      }

      mdformat:on("install:success", function()
        -- Create the installation command.
        vim.notify("Installing mdformat extensions.")
        local extensions = table.concat(mdformat_extensions, " ")
        local python = "~/.local/share/nvim/mason/packages/mdformat/venv/bin/python"
        local pip_cmd = string.format("%s -m pip install %s", python, extensions)

        -- vim.fn.jobstart doesn't work in callback so use popen instead.
        local handle = io.popen(pip_cmd)
        if not handle then
          vim.notify('Could not install "mdformat extensions".', vim.log.levels.ERROR)
          return
        end
        local _ = handle:read("*a")
        handle:close()

        vim.notify('"mdformat extensions" were successfully installed.')
      end)
    end)
  end,
}
