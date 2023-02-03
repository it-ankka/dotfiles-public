local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")

local disabled_sources = (vim.g.disabled_cmp_sources or {})
local enabled_sources = {}

for _, source in ipairs({
  {name = "nvim_lsp"},
  {name = "conjure"},
  {name = "luasnip"},
  {name = "path"},
  {name = "buffer"},
  {name = "calc"},
  {name = "emoji"}}) do
  local disabled_3f = false
  for _, disabled in ipairs(disabled_sources) do
    if (source.name == disabled) then
      disabled_3f = true
    else
    end
  end
  if not disabled_3f then
    table.insert(enabled_sources, source)
  else
  end
end

local sources = enabled_sources

local function prev_item(fallback)
  if cmp.visible() then
    return cmp.select_prev_item({behavior = cmp.SelectBehavior.Insert})
  else
    return fallback()
  end
end

local function next_item(fallback)
  if cmp.visible() then
    return cmp.select_next_item({behavior = cmp.SelectBehavior.Insert})
  else
    return fallback()
  end
end

local mappings = {
  ["<C-b>"] = cmp.mapping.scroll_docs(-4),
  ["<C-f>"] = cmp.mapping.scroll_docs(4),
  ["<C-space>"] = cmp.mapping.complete(),
  ["<C-y>"] = cmp.config.disable,
  ["<C-e>"] = cmp.mapping({i = cmp.mapping.abort(), c = cmp.mapping.close()}),
  ["<S-Tab>"] = prev_item,
  ["<Tab>"] = next_item,
  ["<Up>"] = prev_item,
  ["<Down>"] = next_item,
  ["<CR>"] = cmp.mapping.confirm({select = true})
}

local format = lspkind.cmp_format({
    mode = "symbol_text",
    maxwidth = 50,
    before = function (entry, vim_item)
      vim_item.kind = (lspkind.presets.default[vim_item.kind] .. " " .. vim_item.kind)
      vim_item.menu = ({path = "[Path]", buffer = "[Buffer]", calc = "[Calc]", nvim_lsp = "[LSP]", cmp_tabnine = "[TabNine]", luasnip = "[LuaSnip]", emoji = "[Emoji]"})[entry.source.name]
      return vim_item
    end
})

local function expand(args)
  return luasnip.lsp_expand(args.body)
end

cmp.setup({
  snippet = {expand = expand},
  mapping = mappings,
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered()
  },
  formatting = {format = format},
  sources = sources
})

cmp.setup.cmdline("/",
  {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {{name = "buffer"}}
  })

cmp.setup.cmdline(":",
  {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources(
    {{name = "path"}},
    {{name = "cmdline", option = {ignore_cmds = {"Man", "!", "Shell"}}}})
  })
