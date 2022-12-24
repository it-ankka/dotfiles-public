local vim = vim

local M = {}

--   let darkcolors = {
--         'midnight':         #1c1c1c,
--         'midnight-1':       #5f5faf,
--         'midnight-2':       #585858,
--         'midnight-3':       #121212,
--         'midnight-4':       #1c1c1c,
--         'mystic-blue':      #5f5f87,
--         'mystic-blue+1':    #5f5f87,
--         'victory-blue':     #87afaf,
--         'victory-blue+1':   #87afd7,
--         'jungle-green':     #afd75f,
--         'deep-gold':        #ffaf00,
--         'axiomatic-purple': #d787ff,
--         'brick-red':        #ff8700,
--         'piggy-pink':       #ffafd7,
--         'relaxed-white':    #d7d7d7,
--         'cold-mud':         #ffd7d7,
--         'sky-blue':         #5f5f87,
--         \
--         'full-white':       #ffffff, 
--         'full-black':       #080808,
--         'full-green':       #00ff00,
--         'full-blue':        #0000af,
-- }

M.classic = {
  name = 'mycolor',
  base0 = '#222426',
  base1 = '#272a30',
  base2 = '#26292C',
  base3 = '#2E323C',
  base4 = '#333842',
  base5 = '#4d5154',
  base6 = '#9ca0a4',
  base7 = '#b1b1b1',
  base8 = '#e3e3e1',
  border = '#a1b5b1',
  brown = '#504945',
  white = '#f8f8f0',
  grey = '#8F908A',
  black = '#000000',
  pink = '#ffafd7',
  green = '#afd75f',
  aqua = '#87afd7',
  yellow = '#ffaf00',
  orange = '#fd771f',
  purple = '#d787ff',
  red = '#e95678',
  diff_add = '#3d5213',
  diff_remove = '#4a0f23',
  diff_change = '#27406b',
  diff_text = '#23324d',
}

-- pink -> yellow
-- green -> blue
-- yellow -> green


local function remove_italics(config, colors)
  if not config.italics and colors.style == 'italic' then
    colors.style = nil
  end
  return colors
end

local function highlighter(config)
  return function(group, color)
    color = remove_italics(config, color)
    local style = color.style and 'gui=' .. color.style or 'gui=NONE'
    local fg = color.fg and 'guifg = ' .. color.fg or 'guifg = NONE'
    local bg = color.bg and 'guibg = ' .. color.bg or 'guibg = NONE'
    local sp = color.sp and 'guisp = ' .. color.sp or ''
  vim.cmd(
    'highlight ' .. group .. ' ' .. style .. ' ' .. fg .. ' ' .. bg .. ' ' .. sp
  )
  end
end

M.load_syntax = function(palette)
  return {
    Normal = {
      fg = palette.white,
      bg = palette.base2,
    },
    NormalFloat = {
      bg = palette.base1,
    },
    Pmenu = {
      fg = palette.white,
      bg = palette.base3,
    },
    PmenuSel = {
      fg = palette.base4,
      bg = palette.orange,
    },
    PmenuSelBold = {
      fg = palette.base4,
      bg = palette.orange,
    },
    PmenuThumb = {
      fg = palette.purple,
      bg = palette.aqua,
    },
    PmenuSbar = {
      bg = palette.base3,
    },
    Cursor = {
      style = 'reverse',
    },
    ColorColumn = {
      bg = palette.base3,
    },
    CursorLine = {
      bg = palette.base3,
    },
    NonText = { -- used for "eol", "extends" and "precedes" in listchars
      fg = palette.base5,
    },
    Visual = {
      bg = palette.base4,
    },
    VisualNOS = {
      bg = palette.base3,
    },
    Search = {
      fg = palette.base2,
      bg = palette.green,
    },
    IncSearch = {
      fg = palette.base2,
      bg = palette.orange,
    },
    CursorLineNr = {
      fg = palette.orange,
      bg = palette.base2,
    },
    MatchParen = {
      fg = palette.yellow,
    },
    Question = {
      fg = palette.green,
    },
    ModeMsg = {
      fg = palette.white,
      style = 'bold',
    },
    MoreMsg = {
      fg = palette.white,
      style = 'bold',
    },
    ErrorMsg = {
      fg = palette.red,
      style = 'bold',
    },
    WarningMsg = {
      fg = palette.orange,
      style = 'bold',
    },
    VertSplit = {
      fg = palette.brown,
    },
    LineNr = {
      fg = palette.base5,
      bg = palette.base2,
    },
    SignColumn = {
      fg = palette.white,
      bg = palette.base2,
    },
    StatusLine = {
      fg = palette.base7,
      bg = palette.base3,
    },
    StatusLineNC = {
      fg = palette.grey,
      bg = palette.base3,
    },
    Tabline = {},
    TabLineFill = {},
    TabLineSel = {
      bg = palette.base4,
    },
    SpellBad = {
      fg = palette.red,
      style = 'undercurl',
    },
    SpellCap = {
      fg = palette.purple,
      style = 'undercurl',
    },
    SpellRare = {
      fg = palette.aqua,
      style = 'undercurl',
    },
    SpellLocal = {
      fg = palette.yellow,
      style = 'undercurl',
    },
    SpecialKey = {
      fg = palette.yellow,
    },
    Title = {
      fg = palette.green,
      style = 'bold',
    },
    Directory = {
      fg = palette.aqua,
    },
    DiffAdd = {
      bg = palette.diff_add,
    },
    DiffDelete = {
      bg = palette.diff_remove,
    },
    DiffChange = {
      bg = palette.diff_change,
    },
    DiffText = {
      bg = palette.diff_text,
    },
    diffAdded = {
      fg = palette.green,
    },
    diffRemoved = {
      fg = palette.red,
    },
    Folded = {
      fg = palette.grey,
      bg = palette.base3,
    },
    FoldColumn = {
      fg = palette.white,
      bg = palette.black,
    },
    Constant = {
      fg = palette.aqua,
    },
    Number = {
      fg = palette.orange,
    },
    Float = {
      fg = palette.purple,
    },
    Boolean = {
      fg = palette.purple,
    },
    Character = {
      fg = palette.green,
    },
    String = {
      fg = palette.green,
    },
    Type = {
      fg = palette.aqua,
    },
    Structure = {
      fg = palette.aqua,
    },
    StorageClass = {
      fg = palette.aqua,
    },
    Typedef = {
      fg = palette.aqua,
    },
    Identifier = {
      fg = palette.white,
    },
    Function = {
      fg = palette.yellow,
      style = 'italic',
    },
    Statement = {
      fg = palette.yellow,
    },
    Operator = {
      fg = palette.yellow,
    },
    Label = {
      fg = palette.yellow,
    },
    Keyword = {
      fg = palette.red,
      style = 'italic',
    },
    PreProc = {
      fg = palette.yellow,
    },
    Include = {
      fg = palette.aqua,
    },
    Define = {
      fg = palette.purple,
    },
    Macro = {
      fg = palette.yellow,
    },
    PreCondit = {
      fg = palette.yellow,
    },
    Special = {
      fg = palette.white,
    },
    SpecialChar = {
      fg = palette.yellow,
    },
    Delimiter = {
      fg = palette.white,
    },
    SpecialComment = {
      fg = palette.grey,
      style = 'italic',
    },
    Tag = {
      fg = palette.orange,
    },
    Todo = {
      fg = palette.orange,
    },
    Comment = {
      fg = palette.base6,
      style = 'italic',
    },
    Underlined = {
      style = 'underline',
    },
    Ignore = {},
    Error = {
      fg = palette.red,
    },
    Terminal = {
      fg = palette.white,
      bg = palette.base2,
    },
    EndOfBuffer = {
      fg = palette.base2,
    },
    Conceal = {
      fg = palette.grey,
    },
    vCursor = {
      style = 'reverse',
    },
    iCursor = {
      style = 'reverse',
    },
    lCursor = {
      style = 'reverse',
    },
    CursorIM = {
      style = 'reverse',
    },
    CursorColumn = {
      bg = palette.base3,
    },
    Whitespace = { -- used for "nbsp", "space", "tab" and "trail" in listchars
      fg = palette.base5,
    },
    WildMenu = {
      fg = palette.white,
      bg = palette.orange,
    },
    QuickFixLine = {
      fg = palette.purple,
      style = 'bold',
    },
    Debug = {
      fg = palette.orange,
    },
    debugBreakpoint = {
      fg = palette.base2,
      bg = palette.red,
    },
    Conditional = {
      fg = palette.cyan,
    },
    Repeat = {
      fg = palette.yellow,
    },
    Exception = {
      fg = palette.yellow,
    },
  }
end

M.load_plugin_syntax = function(palette)
  return {
    ["@string"] = {
      fg = palette.green,
    },
    ["@include"] = {
      fg = palette.yellow,
    },
    ["@variable"] = {
      fg = palette.white,
    },
    ["@variable.builtin"] = {
      fg = palette.orange,
    },
    ["@annotation"] = {
      fg = palette.yellow,
    },
    ["@comment"] = {
      fg = palette.base6,
      style = 'italic',
    },
    ["@constant"] = {
      fg = palette.aqua,
    },
    ["@const.builtin"] = {
      fg = palette.purple,
    },
    ["@const.macro"] = {
      fg = palette.purple,
    },
    ["@constructor"] = {
      fg = palette.aqua,
    },
    ["@conditional"] = {
      fg = palette.yellow,
    },
    ["@character"] = {
      fg = palette.green,
    },
    ["@function"] = {
      fg = palette.aqua,
      style = 'italic',
    },
    ["@function.builtin"] = {
      fg = palette.aqua,
    },
    ["@function.macro"] = {
      fg = palette.aqua,
      style = 'italic',
    },
    ["@keyword"] = {
      fg = palette.yellow,
      style = 'italic',
    },
    ["@keyword.function"] = {
      fg = palette.yellow,
      style = 'italic',
    },
    ["@keyword.operator"] = {
      fg = palette.yellow,
    },
    ["@keyword.return"] = {
      fg = palette.yellow,
    },
    ["@method"] = {
      fg = palette.yellow,
    },
    ["@namespace"] = {
      fg = palette.purple,
    },
    ["@number"] = {
      fg = palette.purple,
    },
    ["@operator"] = {
      fg = palette.yellow,
    },
    ["@parameter"] = {
      fg = palette.white,
    },
    ["@parameter.reference"] = {
      fg = palette.white,
    },
    ["@property"] = {
      fg = palette.white,
    },
    ["@punctuation.delimiter"] = {
      fg = palette.white,
    },
    ["@punctuation.bracket"] = {
      fg = palette.white,
    },
    ["@punctuation.special"] = {
      fg = palette.yellow,
    },
    ["@repeat"] = {
      fg = palette.yellow,
    },
    ["@string.regex"] = {
      fg = palette.purple,
    },
    ["@string.escape"] = {
      fg = palette.purple,
    },
    ["@tag"] = {
      fg = palette.yellow,
    },
    ["@tag.delimiter"] = {
      fg = palette.white,
    },
    ["@tag.attribute"] = {
      fg = palette.aqua,
    },
    ["@label"] = {
      fg = palette.yellow,
    },
    ["@type"] = {
      fg = palette.grey,
    },
    ["@exception"] = {
      fg = palette.yellow,
    },
    ["@field"] = {
      fg = palette.white,
    },
    ["@float"] = {
      fg = palette.purple,
    },
    dbui_tables = {
      fg = palette.white,
    },
    DiagnosticSignError = {
      fg = palette.red,
    },
    DiagnosticSignWarn = {
      fg = palette.orange,
    },
    DiagnosticSignInfo = {
      fg = palette.white,
    },
    DiagnosticSignHint = {
      fg = palette.aqua,
    },
    DiagnosticVirtualTextError = {
      fg = palette.red,
    },
    DiagnosticVirtualTextWarn = {
      fg = palette.orange,
    },
    DiagnosticVirtualTextInfo = {
      fg = palette.white,
    },
    DiagnosticVirtualTextHint = {
      fg = palette.aqua,
    },
    DiagnosticUnderlineError = {
      style = 'undercurl',
      sp = palette.red,
    },
    DiagnosticUnderlineWarn = {
      style = 'undercurl',
      sp = palette.orange,
    },
    DiagnosticUnderlineInfo = {
      style = 'undercurl',
      sp = palette.white,
    },
    DiagnosticUnderlineHint = {
      style = 'undercurl',
      sp = palette.aqua,
    },
    CursorWord0 = {
      bg = palette.white,
      fg = palette.black,
    },
    CursorWord1 = {
      bg = palette.white,
      fg = palette.black,
    },
    NvimTreeFolderName = {
      fg = palette.white,
    },
    NvimTreeRootFolder = {
      fg = palette.yellow,
    },
    NvimTreeSpecialFile = {
      fg = palette.white,
      style = 'NONE',
    },

    -- Telescope
    TelescopeBorder = {
      fg = palette.base7,
    },
    TelescopeNormal = {
      fg = palette.base8,
      bg = palette.base0,
    },
    TelescopeSelection = {
      fg = palette.white,
      style = 'bold',
    },
    TelescopeSelectionCaret = {
      fg = palette.aqua,
    },
    TelescopeMultiSelection = {
      fg = palette.yellow,
    },
    TelescopeMatching = {
      fg = palette.aqua,
    },

    -- hrsh7th/nvim-cmp
    CmpDocumentation = { fg = palette.white, bg = palette.base1 },
    CmpDocumentationBorder = { fg = palette.white, bg = palette.base1 },

    CmpItemAbbr = { fg = palette.white },
    CmpItemAbbrMatch = { fg = palette.aqua },
    CmpItemAbbrMatchFuzzy = { fg = palette.aqua },

    CmpItemKindDefault = { fg = palette.white },
    CmpItemMenu = { fg = palette.base6 },

    CmpItemKindKeyword = { fg = palette.yellow },
    CmpItemKindVariable = { fg = palette.yellow },
    CmpItemKindConstant = { fg = palette.yellow },
    CmpItemKindReference = { fg = palette.yellow },
    CmpItemKindValue = { fg = palette.yellow },

    CmpItemKindFunction = { fg = palette.aqua },
    CmpItemKindMethod = { fg = palette.aqua },
    CmpItemKindConstructor = { fg = palette.aqua },

    CmpItemKindClass = { fg = palette.orange },
    CmpItemKindInterface = { fg = palette.orange },
    CmpItemKindStruct = { fg = palette.orange },
    CmpItemKindEvent = { fg = palette.orange },
    CmpItemKindEnum = { fg = palette.orange },
    CmpItemKindUnit = { fg = palette.orange },

    CmpItemKindModule = { fg = palette.green },

    CmpItemKindProperty = { fg = palette.aqua },
    CmpItemKindField = { fg = palette.aqua },
    CmpItemKindTypeParameter = { fg = palette.aqua },
    CmpItemKindEnumMember = { fg = palette.aqua },
    CmpItemKindOperator = { fg = palette.aqua },

    -- ray-x/lsp_signature.nvim
    LspSignatureActiveParameter = { fg = palette.orange },
  }
end

local default_config = {
  palette = M.classic,
  custom_hlgroups = {},
  italics = true,
}

M.setup = function(config)
  vim.cmd('hi clear')
  if vim.fn.exists('syntax_on') then
    vim.cmd('syntax reset')
  end
  vim.o.background = 'dark'
  vim.o.termguicolors = true
  config = config or {}
  config = vim.tbl_deep_extend('keep', config, default_config)
  local used_palette = config.palette or M.classic
  vim.g.colors_name = used_palette.name
  local syntax = M.load_syntax(used_palette)
  syntax = vim.tbl_deep_extend('keep', config.custom_hlgroups, syntax)
  local highlight = highlighter(config)
  for group, colors in pairs(syntax) do
    highlight(group, colors)
  end
  local plugin_syntax = M.load_plugin_syntax(used_palette)
  plugin_syntax = vim.tbl_deep_extend(
    'keep',
    config.custom_hlgroups,
    plugin_syntax
  )
  for group, colors in pairs(plugin_syntax) do
    highlight(group, colors)
  end
end

return M
