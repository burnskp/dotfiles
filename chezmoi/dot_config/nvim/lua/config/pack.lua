local M = {}

local plugin_modules = {
  "colorscheme",
  "dial",
  "gitsigns",
  "lualine",
  "mini",
  "render-markdown",
  "snacks",
  "surround",
  "treesitter",
  "treesj",
  "which-key",
}

local collected_specs

local function normalize_src(src)
  if src:match("^https?://") or src:match("^[%w+.-]+://") or src:match("^git@") then
    return src
  end

  if src:match("^[^/]+/[^/]+$") then
    return "https://github.com/" .. src
  end

  return src
end

local function plugin_name(src)
  local name = src:gsub("%.git$", ""):match("([^/]+)$") or src
  return name
end

local function is_plugin_spec(spec)
  if type(spec) ~= "table" then
    return false
  end

  if spec.src ~= nil or spec.url ~= nil then
    return true
  end

  if type(spec[1]) ~= "string" then
    return false
  end

  for key in pairs(spec) do
    if type(key) ~= "number" then
      return true
    end
  end

  return vim.tbl_count(spec) == 1
end

local function merge_spec(dst, src)
  for key, value in pairs(src) do
    if key ~= "dependencies" then
      dst[key] = value
    end
  end
end

local function collect_spec(spec, acc, order, seen)
  if spec == nil then
    return
  end

  if type(spec) == "string" then
    spec = { src = spec }
  end

  if not is_plugin_spec(spec) then
    for _, item in ipairs(spec) do
      collect_spec(item, acc, order, seen)
    end
    return
  end

  if spec.dependencies then
    collect_spec(spec.dependencies, acc, order, seen)
  end

  local item = vim.deepcopy(spec)
  item.src = normalize_src(item.src or item.url or item[1])
  item.name = item.name or plugin_name(item.src)

  if seen[item.name] then
    merge_spec(acc[seen[item.name]], item)
    return
  end

  table.insert(order, item.name)
  seen[item.name] = #order
  acc[#order] = item
end

local function load_specs()
  if collected_specs then
    return collected_specs
  end

  local specs = {}
  local order = {}
  local seen = {}

  for _, module in ipairs(plugin_modules) do
    collect_spec(require("plugins." .. module), specs, order, seen)
  end

  collected_specs = specs
  return collected_specs
end

local function main_candidates(spec)
  local raw = spec.main or spec.name or plugin_name(spec.src)
  local base = raw:gsub("%.git$", ""):gsub("%.nvim$", ""):gsub("%.lua$", "")
  local candidates = { base }
  local without_prefix = base:gsub("^nvim%-", "")
  if without_prefix ~= base then
    table.insert(candidates, without_prefix)
  end
  return candidates
end

local function apply_opts(spec, opts)
  if spec.config then
    spec.config(spec, opts)
    return
  end

  if opts == nil then
    return
  end

  for _, candidate in ipairs(main_candidates(spec)) do
    local ok, mod = pcall(require, candidate)
    if ok and type(mod.setup) == "function" then
      mod.setup(opts)
      return
    end
  end
end

local function map_keys(keys)
  if not keys then
    return
  end

  for _, mapping in ipairs(keys) do
    local lhs = mapping[1]
    local rhs = mapping[2]
    local mode = mapping.mode or "n"
    local opts = {}

    for key, value in pairs(mapping) do
      if type(key) ~= "number" and key ~= "mode" then
        opts[key] = value
      end
    end

    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

function M.bootstrap()
  local specs = load_specs()
  local pack_specs = {}

  for _, spec in ipairs(specs) do
    if type(spec.init) == "function" then
      spec.init(spec)
    end

    local pack_spec = {
      src = spec.src,
      name = spec.name,
    }

    if type(spec.version) == "string" or type(spec.version) == "table" then
      pack_spec.version = spec.version
    end

    table.insert(pack_specs, pack_spec)
  end

  vim.pack.add(pack_specs, { confirm = false, load = true })
end

function M.configure()
  for _, spec in ipairs(load_specs()) do
    local opts = spec.opts
    if type(opts) == "function" then
      opts = opts(spec)
    end

    apply_opts(spec, opts)

    local keys = spec.keys
    if type(keys) == "function" then
      keys = keys()
    end

    map_keys(keys)
  end
end

return M
