local M = {}

local config = require "if.config"
local colors = require("if.theme.palettes." .. config.theme.palette)
local transparent = config.theme.transparent
local bg = transparent and colors.none or colors.bg

M.base = {
  Normal = { fg = colors.white, bg = bg },
  NormalFloat = { fg = colors.white, bg = bg },
  FloatBorder = { fg = colors.float_border, bg = bg },
  WinSeparator = { fg = colors.bg2 },
  VertSplit = { fg = colors.border },
  SignColumn = { bg = bg },
  EndOfBuffer = { fg = colors.bg },
  Cursor = { bg = colors.white, fg = colors.black },
  CursorLine = { bg = colors.bg2 },
  CursorColumn = { bg = bg },
  ColorColumn = { bg = bg },
  LineNr = { fg = colors.comment },
  CursorLineNr = { fg = colors.plum },
  Visual = { bg = colors.charcoal },
  VisualNOS = { bg = colors.charcoal },

  Pmenu = { fg = colors.white, bg = bg },
  PmenuSel = { fg = colors.black, bg = colors.blue },
  PmenuSbar = { bg = bg },
  PmenuThumb = { bg = colors.charcoal },

  Search = { bg = colors.magenta, fg = colors.black, bold = true, italic = true },
  IncSearch = { bg = colors.green, fg = colors.black, bold = true, italic = true },
  Substitute = { bg = colors.blue, fg = colors.black, bold = true },
  MatchParen = { bg = colors.none, fg = colors.grape, bold = true, link = "" },

  Folded = { fg = colors.comment, bg = bg },
  FoldColumn = { fg = colors.comment },

  DiffAdd = { bg = "#2A304B" },
  DiffChange = { bg = "#384268" },
  DiffDelete = { bg = "#34232C" },
  DiffText = { bg = "#484466" },

  ErrorMsg = { fg = colors.red },
  WarningMsg = { fg = colors.yellow },
  ModeMsg = { fg = colors.white, bold = true },
  MoreMsg = { fg = colors.green },
  Question = { fg = colors.green },

  SpellBad = { sp = colors.red, undercurl = true },
  SpellCap = { sp = colors.yellow, undercurl = true },
  SpellLocal = { sp = colors.blue, undercurl = true },
  SpellRare = { sp = colors.magenta, undercurl = true },

  TabLine = { fg = colors.comment, bg = bg },
  TabLineFill = { bg = bg },
  TabLineSel = { fg = colors.white, bg = bg },

  IfTabFill = { bg = bg },
  IfBufOn = { fg = colors.white, bg = bg },
  IfBufOff = { fg = colors.comment, bg = bg },
  IfBufOnMod = { fg = colors.green, bg = bg },
  IfBufOffMod = { fg = colors.green, bg = bg },
  IfTabOn = { fg = colors.blue, bg = colors.blue, bold = true },
  IfTabOff = { fg = colors.comment, bg = bg },
  IfWinOn = { fg = colors.white, bg = bg },
  IfWinOff = { fg = colors.comment, bg = bg },

  StatusLine = { bg = bg, fg = colors.none },
  StatusLineNC = { bg = bg, fg = colors.none },

  WinBar = { bg = bg },
  WinBarNC = { bg = bg },

  Directory = { fg = colors.blue },
  Title = { fg = colors.blue, bold = true },
  NonText = { fg = colors.charcoal },
  SpecialKey = { fg = colors.charcoal },
  Conceal = { fg = colors.comment },
}

M.syntax = {
  Comment = { fg = colors.comment, italic = true },
  Constant = { fg = colors.orange },
  String = { fg = colors.green },
  Character = { fg = colors.green },
  Number = { fg = colors.orange },
  Boolean = { fg = colors.orange },
  Float = { fg = colors.orange },

  Identifier = { fg = colors.red },
  Function = { fg = colors.blue },

  Statement = { fg = colors.magenta },
  Conditional = { fg = colors.plum },
  Repeat = { fg = colors.tangerine },
  Label = { fg = colors.cyan },
  Operator = { fg = colors.cyan },
  Keyword = { fg = colors.magenta },
  Exception = { fg = colors.magenta },

  PreProc = { fg = colors.yellow },
  Include = { fg = colors.magenta },
  Define = { fg = colors.magenta },
  Macro = { fg = colors.magenta },
  PreCondit = { fg = colors.yellow },

  Type = { fg = colors.yellow },
  StorageClass = { fg = colors.yellow },
  Structure = { fg = colors.yellow },
  Typedef = { fg = colors.yellow },

  Special = { fg = colors.cyan },
  SpecialChar = { fg = colors.orange },
  Tag = { fg = colors.red },
  Delimiter = { fg = colors.white },
  SpecialComment = { fg = colors.comment },
  Debug = { fg = colors.red },

  Underlined = { underline = true },
  Ignore = {},
  Error = { fg = colors.red },
  Todo = { fg = colors.magenta, bold = true },
}

M.treesitter = {
  ["@variable"] = { fg = colors.white },
  ["@variable.builtin"] = { fg = colors.orange },
  ["@variable.parameter"] = { fg = colors.red },
  ["@variable.member"] = { fg = colors.red },
  ["@variable.member.key"] = { fg = colors.red },

  ["@module"] = { fg = colors.red },

  ["@constant"] = { fg = colors.orange },
  ["@constant.builtin"] = { fg = colors.orange },
  ["@constant.macro"] = { fg = colors.red },

  ["@string"] = { fg = colors.green },
  ["@string.regex"] = { fg = colors.cyan },
  ["@string.escape"] = { fg = colors.cyan },
  ["@character"] = { fg = colors.red },
  ["@number"] = { fg = colors.orange },
  ["@number.float"] = { fg = colors.orange },

  ["@annotation"] = { fg = "#be5046" },
  ["@attribute"] = { fg = colors.yellow },
  ["@error"] = { fg = colors.red },

  ["@keyword"] = { fg = colors.magenta },
  ["@keyword.function"] = { fg = colors.magenta },
  ["@keyword.return"] = { fg = colors.magenta },
  ["@keyword.operator"] = { fg = colors.magenta },
  ["@keyword.import"] = { link = "Include" },
  ["@keyword.conditional"] = { fg = colors.magenta },
  ["@keyword.conditional.ternary"] = { fg = colors.magenta },
  ["@keyword.repeat"] = { fg = colors.yellow },
  ["@keyword.storage"] = { fg = colors.yellow },
  ["@keyword.directive.define"] = { fg = colors.magenta },
  ["@keyword.directive"] = { fg = colors.yellow },
  ["@keyword.exception"] = { fg = colors.red },

  ["@function"] = { fg = colors.blue },
  ["@function.builtin"] = { fg = colors.blue },
  ["@function.macro"] = { fg = colors.red },
  ["@function.call"] = { fg = colors.blue },
  ["@function.method"] = { fg = colors.blue },
  ["@function.method.call"] = { fg = colors.blue },
  ["@constructor"] = { fg = colors.cyan },

  ["@operator"] = { fg = colors.white },
  ["@reference"] = { fg = colors.white },
  ["@punctuation.bracket"] = { fg = "#be5046" },
  ["@punctuation.delimiter"] = { fg = "#be5046" },
  ["@symbol"] = { fg = colors.green },
  ["@tag"] = { fg = colors.yellow },
  ["@tag.attribute"] = { fg = colors.red },
  ["@tag.delimiter"] = { fg = "#be5046" },
  ["@text"] = { fg = colors.white },
  ["@text.emphasis"] = { fg = colors.orange },
  ["@text.strike"] = { fg = "#be5046", strikethrough = true },
  ["@type.builtin"] = { fg = colors.yellow },
  ["@definition"] = { sp = colors.comment, underline = true },
  ["@scope"] = { bold = true },
  ["@property"] = { fg = colors.red },

  ["@markup.heading"] = { fg = colors.blue },
  ["@markup.raw"] = { fg = colors.orange },
  ["@markup.link"] = { fg = colors.red },
  ["@markup.link.url"] = { fg = colors.orange, underline = true },
  ["@markup.link.label"] = { fg = colors.cyan },
  ["@markup.list"] = { fg = colors.red },
  ["@markup.strong"] = { bold = true },
  ["@markup.underline"] = { underline = true },
  ["@markup.italic"] = { italic = true },
  ["@markup.strikethrough"] = { strikethrough = true },
  ["@markup.quote"] = {},

  ["@comment"] = { fg = colors.comment },
  ["@comment.todo"] = { fg = colors.charcoal, bg = colors.white },
  ["@comment.warning"] = { fg = colors.bg, bg = colors.orange },
  ["@comment.note"] = { fg = colors.black, bg = colors.blue },
  ["@comment.danger"] = { fg = colors.bg, bg = colors.red },

  ["@diff.plus"] = { fg = colors.green },
  ["@diff.minus"] = { fg = colors.red },
  ["@diff.delta"] = { fg = colors.charcoal },
}

M.lazy = {
  LazyH1 = { bg = colors.green, fg = colors.black },
  LazyH2 = { fg = colors.red, bold = true, underline = true },
  LazyButton = { bg = colors.border, fg = colors.charcoal },
  LazyReasonPlugin = { fg = colors.red },
  LazyValue = { fg = colors.teal },
  LazyDir = { fg = colors.white },
  LazyUrl = { fg = colors.white },
  LazyCommit = { fg = colors.green },
  LazyNoCond = { fg = colors.red },
  LazySpecial = { fg = colors.blue },
  LazyReasonFt = { fg = colors.fuchsia },
  LazyOperator = { fg = colors.white },
  LazyReasonKeys = { fg = colors.teal },
  LazyTaskOutput = { fg = colors.white },
  LazyCommitIssue = { fg = colors.peach },
  LazyReasonEvent = { fg = colors.yellow },
  LazyReasonStart = { fg = colors.white },
  LazyReasonRuntime = { fg = colors.navy },
  LazyReasonCmd = { fg = colors.yellow },
  LazyReasonSource = { fg = colors.cyan },
  LazyReasonImport = { fg = colors.white },
  LazyProgressDone = { fg = colors.green },
}

M.mason = {
  MasonNormal = { fg = colors.white, bg = bg },
  MasonHeader = { bg = colors.green, fg = colors.black, bold = true },
  MasonHeaderSecondary = { bg = colors.blue, fg = colors.black, bold = true },
  MasonHighlight = { fg = colors.blue },
  MasonHighlightBlock = { bg = colors.blue, fg = colors.black },
  MasonHighlightBlockBold = { bg = colors.blue, fg = colors.black, bold = true },
  MasonHighlightSecondary = { fg = colors.yellow },
  MasonHighlightBlockSecondary = { bg = colors.yellow, fg = colors.black },
  MasonHighlightBlockBoldSecondary = { bg = colors.yellow, fg = colors.black, bold = true },
  MasonMuted = { fg = colors.comment },
  MasonMutedBlock = { bg = colors.charcoal, fg = colors.white },
  MasonMutedBlockBold = { bg = colors.charcoal, fg = colors.white, bold = true },
  MasonError = { fg = colors.red },
  MasonWarning = { fg = colors.yellow },
  MasonHeading = { bold = true },
}

M.misc = {
  Added = { fg = colors.green },
  Removed = { fg = colors.red },
  Changed = { fg = colors.yellow },
  MatchWord = { bg = colors.charcoal, fg = colors.white },
  QuickFixLine = { bg = bg },
  healthSuccess = { bg = colors.green, fg = colors.black },
  NvimInternalError = { fg = colors.red },
  DevIconDefault = { fg = colors.red },
  FloatTitle = { fg = colors.white, bg = colors.charcoal },
}

local stl_style = config.style or "compact"

local stl_compact = {
  IfNormalMode = { fg = colors.green, bold = true },
  IfVisualMode = { fg = colors.blue, bold = true },
  IfInsertMode = { fg = colors.lavender, bold = true },
  IfTerminalMode = { fg = colors.green, bold = true },
  IfNTerminalMode = { fg = colors.yellow, bold = true },
  IfReplaceMode = { fg = colors.orange, bold = true },
  IfConfirmMode = { fg = colors.teal, bold = true },
  IfCommandMode = { fg = colors.orange, bold = true },
  IfSelectMode = { fg = colors.blue, bold = true },

  IfTelescopeMode = { fg = colors.yellow, bold = true },
  IfExplorerMode = { fg = colors.cyan, bold = true },
  IfLazyGitMode = { fg = colors.cyan, bold = true },
  IfLazyNvimMode = { fg = colors.magenta, bold = true },

  IfFile = { fg = colors.white },
  IfFileIcon = { fg = colors.white },

  IfGitIcon = { fg = colors.magenta },
  IfGitText = { fg = colors.gray },
  IfLsp = { fg = colors.navy },
  IfLspMsg = { fg = colors.green },

  IfLspIcon = { fg = colors.navy },
  IfLspText = { fg = colors.white },
  IfCwdIcon = { fg = colors.peach },
  IfCwdText = { fg = colors.white },
  IfCursorIcon = { fg = colors.orange },
  IfCursorText = { fg = colors.white },
  IfFolderIcon = { fg = colors.red },
  IfFolderText = { fg = colors.white },
  IfQfIcon = { fg = colors.magenta },
  IfQfText = { fg = colors.gray },

  IfLspError = { fg = colors.red },
  IfLspWarning = { fg = colors.yellow },
  IfLspHints = { fg = colors.fuchsia },
  IfLspInfo = { fg = colors.green },
  IfLspProgress = { fg = colors.charcoal },

  SnacksPickerTitle = { fg = colors.red, bold = true },
  SnacksPickerInputTitle = { fg = colors.red, bold = true },
  SnacksPickerPreviewTitle = { fg = colors.green, bold = true },
}

local stl_block = {
  IfNormalMode = { bg = colors.green, fg = colors.black, bold = true },
  IfVisualMode = { bg = colors.blue, fg = colors.black, bold = true },
  IfInsertMode = { bg = colors.lavender, fg = colors.black, bold = true },
  IfTerminalMode = { bg = colors.green, fg = colors.black, bold = true },
  IfNTerminalMode = { bg = colors.yellow, fg = colors.black, bold = true },
  IfReplaceMode = { bg = colors.orange, fg = colors.black, bold = true },
  IfConfirmMode = { bg = colors.teal, fg = colors.black, bold = true },
  IfCommandMode = { bg = colors.orange, fg = colors.black, bold = true },
  IfSelectMode = { bg = colors.blue, fg = colors.black, bold = true },

  IfTelescopeMode = { bg = colors.yellow, fg = colors.black, bold = true },
  IfExplorerMode = { bg = colors.cyan, fg = colors.black, bold = true },
  IfLazyGitMode = { bg = colors.cyan, fg = colors.black, bold = true },
  IfLazyNvimMode = { bg = colors.magenta, fg = colors.black, bold = true },

  IfFileIcon = { bg = colors.stl_bg, fg = colors.white },
  IfFile = { bg = colors.stl_bg, fg = colors.white },

  IfGitIcon = { fg = colors.magenta },
  IfGitText = { fg = colors.gray },
  IfLsp = { bg = colors.stl_bg, fg = colors.white },
  IfLspMsg = { bg = colors.green, fg = colors.black },

  IfLspIcon = { bg = colors.sapphire, fg = colors.black },
  IfLspText = { bg = colors.stl_bg, fg = colors.white },
  IfCwdIcon = { bg = colors.peach, fg = colors.black },
  IfCwdText = { bg = colors.stl_bg, fg = colors.white },
  IfCursorIcon = { bg = colors.orange, fg = colors.black },
  IfCursorText = { bg = colors.stl_bg, fg = colors.white },
  IfFolderIcon = { bg = colors.red, fg = colors.black },
  IfFolderText = { bg = colors.stl_bg, fg = colors.white },
  IfQfIcon = { bg = colors.magenta, fg = colors.black },
  IfQfText = { bg = colors.stl_bg, fg = colors.white },

  IfLspError = { fg = colors.red },
  IfLspWarning = { fg = colors.yellow },
  IfLspHints = { fg = colors.fuchsia },
  IfLspInfo = { fg = colors.green },
  IfLspProgress = { fg = colors.charcoal },

  SnacksPickerTitle = { bg = colors.red, fg = colors.black, bold = true },
  SnacksPickerInputTitle = { bg = colors.red, fg = colors.black, bold = true },
  SnacksPickerPreviewTitle = { bg = colors.green, fg = colors.black, bold = true },
}

M.statusline = stl_style == "block" and stl_block or stl_compact

M.dropbar = {
  DropBarIconKindConstant = { fg = colors.orange, bg = colors.none },
  DropBarIconKindFunction = { fg = colors.blue, bg = colors.none },
  DropBarIconKindIdentifier = { fg = colors.red, bg = colors.none },
  DropBarIconKindField = { fg = colors.red, bg = colors.none },
  DropBarIconKindVariable = { fg = colors.magenta, bg = colors.none },
  DropBarIconKindSnippet = { fg = colors.red, bg = colors.none },
  DropBarIconKindText = { fg = colors.green, bg = colors.none },
  DropBarIconKindType = { fg = colors.yellow, bg = colors.none },
  DropBarIconKindKeyword = { fg = colors.ivory, bg = colors.none },
  DropBarIconKindMethod = { fg = colors.blue, bg = colors.none },
  DropBarIconKindConstructor = { fg = colors.blue, bg = colors.none },
  DropBarIconKindFolder = { fg = colors.blue, bg = colors.none },
  DropBarIconKindModule = { fg = colors.yellow, bg = colors.none },
  DropBarIconKindProperty = { fg = colors.red, bg = colors.none },
  DropBarIconKindEnum = { fg = colors.blue, bg = colors.none },
  DropBarIconKindUnit = { fg = colors.magenta, bg = colors.none },
  DropBarIconKindClass = { fg = colors.teal, bg = colors.none },
  DropBarIconKindFile = { fg = colors.ivory, bg = colors.none },
  DropBarIconKindInterface = { fg = colors.green, bg = colors.none },
  DropBarIconKindColor = { fg = colors.white, bg = colors.none },
  DropBarIconKindReference = { fg = colors.white, bg = colors.none },
  DropBarIconKindEnumMember = { fg = colors.fuchsia, bg = colors.none },
  DropBarIconKindStruct = { fg = colors.magenta, bg = colors.none },
  DropBarIconKindValue = { fg = colors.cyan, bg = colors.none },
  DropBarIconKindEvent = { fg = colors.yellow, bg = colors.none },
  DropBarIconKindOperator = { fg = colors.white, bg = colors.none },
  DropBarIconKindTypeParameter = { fg = colors.red, bg = colors.none },
  DropBarIconKindNamespace = { fg = colors.teal, bg = colors.none },
  DropBarIconKindPackage = { fg = colors.green, bg = colors.none },
  DropBarIconKindString = { fg = colors.green, bg = colors.none },
  DropBarIconKindNumber = { fg = colors.peach, bg = colors.none },
  DropBarIconKindBoolean = { fg = colors.orange, bg = colors.none },
  DropBarIconKindArray = { fg = colors.blue, bg = colors.none },
  DropBarIconKindObject = { fg = colors.magenta, bg = colors.none },
  DropBarIconKindNull = { fg = colors.cyan, bg = colors.none },
  DropBarIconKindLsp = { fg = colors.blue, bg = colors.none },
  DropBarIconKindMarkdownH1 = { fg = colors.red, bg = colors.none },
  DropBarIconKindMarkdownH2 = { fg = colors.orange, bg = colors.none },
  DropBarIconKindMarkdownH3 = { fg = colors.yellow, bg = colors.none },
  DropBarIconKindMarkdownH4 = { fg = colors.green, bg = colors.none },
  DropBarIconKindMarkdownH5 = { fg = colors.blue, bg = colors.none },
  DropBarIconKindMarkdownH6 = { fg = colors.magenta, bg = colors.none },
  DropBarKindDefault = { fg = colors.charcoal, bg = colors.none },
  DropBarIconUISeparator = { fg = colors.red, bg = colors.none },
  DropBarIconUISeparatorMenu = { fg = colors.red, bg = colors.none },
  DropBarIconUIPickPivot = { fg = colors.red, bg = colors.none, bold = true },
  DropBarCurrentContext = { bg = colors.none },
  DropBarCurrentContextName = { fg = colors.ivory, bg = colors.none, bold = true },
  DropBarMenuCurrentContext = { bg = colors.none, link = "" },
  DropBarMenuHoverEntry = { link = "CursorLine" },
}

M.diagnostics = {
  DiagnosticError = { fg = colors.red },
  DiagnosticWarn = { fg = colors.yellow },
  DiagnosticInfo = { fg = colors.white },
  DiagnosticHint = { fg = colors.magenta },
  DiagnosticOk = { fg = colors.green },

  DiagnosticVirtualTextError = { fg = colors.peach, link = "" },
  DiagnosticVirtualTextWarn = { fg = colors.sunshine, link = "" },
  DiagnosticVirtualTextInfo = { fg = colors.aqua, link = "" },
  DiagnosticVirtualTextHint = { fg = colors.lavender, link = "" },
  DiagnosticVirtualTextOk = { fg = colors.lime, link = "" },

  DiagnosticUnderlineError = { sp = colors.red, undercurl = true, italic = true },
  DiagnosticUnderlineWarn = { sp = colors.yellow, undercurl = true, italic = true },
  DiagnosticUnderlineInfo = { sp = colors.white, undercurl = true, italic = true },
  DiagnosticUnderlineHint = { sp = colors.magenta, undercurl = true, italic = true },
  DiagnosticUnderlineOk = { sp = colors.green, undercurl = true, italic = true },
}

M.lsp = {
  LspReferenceText = { bg = bg },
  LspReferenceRead = { bg = bg },
  LspReferenceWrite = { bg = bg },
  LspSignatureActiveParameter = { fg = colors.orange, bold = true },
  LspInlayHint = { fg = colors.comment },
}

M.dashboard = {
  IfDashAscii = { bg = colors.none, fg = colors.navy },
  IfDashIcon = { bg = colors.none, fg = colors.blue },
  IfDashLabel = { bg = colors.none, fg = colors.white },
  IfDashKey = { bg = colors.none, fg = colors.orange },
  IfDashDesc = { bg = colors.none, fg = colors.comment },
  IfDashFooter = { bg = colors.none, fg = colors.comment },
  IfDashSep = { bg = colors.none, fg = colors.bg },
  IfDashIconProject = { bg = colors.none, fg = colors.green },
  IfDashIconHistory = { bg = colors.none, fg = colors.blue },
  IfDashIconTools = { bg = colors.none, fg = colors.orange },
  IfDashIconGit = { bg = colors.none, fg = colors.magenta },
  IfDashIconSystem = { bg = colors.none, fg = colors.red },
  IfDashFocusLabel = { bg = bg, fg = colors.white, bold = true },
  IfDashFocusIcon = { bg = bg, fg = colors.white, bold = true },
  IfDashFocusKey = { bg = bg, fg = colors.orange, bold = true },
  IfDashFocusDesc = { bg = bg, fg = colors.comment },
  IfDashFocusCell = { bg = bg },
}

do
  local logo = require "if.ui.logo"
  local header = config.dashboard and config.dashboard.components and config.dashboard.components.header
  local mode = header and header.color or "solid"
  local from, to
  if mode == "neovim" then
    from, to = logo.NEOVIM_GREEN, logo.NEOVIM_BLUE
  else
    from, to = colors.green, colors.blue
  end

  M.dashboard.IfDashLogoLeft = { bg = colors.none, fg = from }
  M.dashboard.IfDashLogoRight = { bg = colors.none, fg = to }

  for i = 1, logo.STEPS do
    local t = logo.STEPS > 1 and (i - 1) / (logo.STEPS - 1) or 0
    M.dashboard["IfDashLogoMid" .. i] = { bg = colors.none, fg = logo.mix(from, to, t) }
  end
end

M.explorer = {
  IfExplorerNormal = { bg = bg },
  IfExplorerTitle = { link = "SnacksPickerInputTitle" },
  IfExplorerSep = { fg = colors.bg, bg = bg },
}

M.plugins = {
  ["@property"] = { fg = colors.peach },
  ["@parameter"] = { fg = colors.orange },
  ["@operator"] = { fg = colors.cyan },
  ["@punctuation.bracket"] = { fg = colors.cyan },
  ["@function.builtin"] = { fg = colors.cyan },
  ["@punctuation.delimiter"] = { fg = colors.cyan },
  ["@namespace.builtin"] = { fg = colors.yellow },
  ["@comment"] = { fg = colors.comment, italic = true },

  LuaDocumentTag = { fg = colors.plum },
  LuaDocumentParam = { fg = colors.orange },
  LuaGlobalVim = { fg = colors.mustard },
  ["@variable.member.lua"] = { fg = colors.red, link = "" },

  ["@type.qualifier.tsx"] = { fg = colors.magenta, link = "" },
  ["@type.qualifier.vue"] = { fg = colors.magenta, link = "" },
  ["@type.qualifier.typescript"] = { fg = colors.magenta, link = "" },
  ["@type.qualifier.javascript"] = { fg = colors.magenta, link = "" },
  ["@type.qualifier.astro"] = { fg = colors.magenta, link = "" },
  ["@type.swift"] = { fg = colors.yellow, link = "" },

  ["@parameter.tsx"] = { fg = colors.orange, link = "" },
  ["@parameter.vue"] = { fg = colors.orange, link = "" },
  ["@parameter.javascript"] = { fg = colors.orange, link = "" },
  ["@parameter.typescript"] = { fg = colors.orange, link = "" },
  ["@parameter.swift"] = { fg = colors.orange, link = "" },

  ["@variable.parameter.tsx"] = { fg = colors.orange, link = "" },
  ["@variable.parameter.vue"] = { fg = colors.orange, link = "" },
  ["@variable.parameter.javascript"] = { fg = colors.orange, link = "" },
  ["@variable.parameter.typescript"] = { fg = colors.orange, link = "" },
  ["@variable.parameter.lua"] = { fg = colors.orange, link = "" },
  ["@variable.parameter.java"] = { fg = colors.orange, link = "" },
  ["@variable.parameter.swift"] = { fg = colors.orange, link = "" },

  ["@property.tsx"] = { fg = colors.peach },
  ["@property.vue"] = { fg = colors.peach },
  ["@property.javascript"] = { fg = colors.peach },
  ["@property.typescript"] = { fg = colors.peach },
  ["@property.html"] = { fg = colors.peach },
  ["@property.xml"] = { fg = colors.peach },
  ["@property.swift"] = { fg = colors.peach },

  ["@tag.tsx"] = { fg = colors.red },
  ["@tag.vue"] = { fg = colors.red },
  ["@tag.javascript"] = { fg = colors.red },
  ["@tag.typescript"] = { fg = colors.red },
  ["@tag.html"] = { fg = colors.red },
  ["@tag.xml"] = { fg = colors.red },
  ["@tag.astro"] = { fg = colors.red },
  ["@tag.swift"] = { fg = colors.red },

  ["@type.astro"] = { link = "@tag.astro" },

  ["@tag.builtin.tsx"] = { fg = colors.red },
  ["@tag.builtin.javascript"] = { fg = colors.red },
  ["@tag.builtin.astro"] = { fg = colors.red },
  ["@tag.builtin.swift"] = { fg = colors.red, link = "" },

  ["@constructor.tsx"] = { fg = colors.red, link = "" },
  ["@constructor.vue"] = { fg = colors.red, link = "" },
  ["@constructor.javascript"] = { fg = colors.red, link = "" },
  ["@constructor.typescript"] = { fg = colors.red, link = "" },
  ["@constructor.astro"] = { fg = colors.red, link = "" },
  ["@constructor.swift"] = { fg = colors.red, link = "" },

  ["@operator.tsx"] = { fg = colors.cyan },
  ["@operator.vue"] = { fg = colors.cyan },
  ["@operator.javascript"] = { fg = colors.cyan },
  ["@operator.typescript"] = { fg = colors.cyan },
  ["@operator.html"] = { fg = colors.cyan },
  ["@operator.xml"] = { fg = colors.cyan },
  ["@operator.astro"] = { fg = colors.cyan },
  ["@operator.swift"] = { fg = colors.cyan },

  ["@punctuation.special.tsx"] = { fg = colors.magenta },
  ["@punctuation.special.vue"] = { fg = colors.magenta },
  ["@punctuation.special.javascript"] = { fg = colors.magenta },
  ["@punctuation.special.typescript"] = { fg = colors.magenta },
  ["@punctuation.special.astro"] = { fg = colors.magenta },
  ["@punctuation.special.swift"] = { fg = colors.magenta },

  ["@tag.attribute.tsx"] = { fg = colors.orange },
  ["@tag.attribute.vue"] = { fg = colors.orange },
  ["@tag.attribute.javascript"] = { fg = colors.orange },
  ["@tag.attribute.typescript"] = { fg = colors.orange },
  ["@tag.attribute.html"] = { fg = colors.orange },
  ["@tag.attribute.xml"] = { fg = colors.orange },
  ["@tag.attribute.astro"] = { fg = colors.orange },
  ["@tag.attribute.swift"] = { fg = colors.orange },

  ["@tag.delimiter.tsx"] = { fg = colors.cyan },
  ["@tag.delimiter.vue"] = { fg = colors.cyan },
  ["@tag.delimiter.javascript"] = { fg = colors.cyan },
  ["@tag.delimiter.typescript"] = { fg = colors.cyan },
  ["@tag.delimiter.html"] = { fg = colors.cyan },
  ["@tag.delimiter.xml"] = { fg = colors.cyan },
  ["@tag.delimiter.astro"] = { fg = colors.cyan },
  ["@tag.delimiter.swift"] = { fg = colors.cyan },

  ["@punctuation.delimiter.tsx"] = { fg = colors.cyan },
  ["@punctuation.delimiter.vue"] = { fg = colors.cyan },
  ["@punctuation.delimiter.javascript"] = { fg = colors.cyan },
  ["@punctuation.delimiter.typescript"] = { fg = colors.cyan },
  ["@punctuation.delimiter.html"] = { fg = colors.cyan },
  ["@punctuation.delimiter.xml"] = { fg = colors.cyan },
  ["@punctuation.delimiter.astro"] = { fg = colors.cyan },
  ["@punctuation.delimiter.swift"] = { fg = colors.cyan },

  ["@punctuation.bracket.tsx"] = { fg = colors.cyan },
  ["@punctuation.bracket.vue"] = { fg = colors.cyan },
  ["@punctuation.bracket.javascript"] = { fg = colors.cyan },
  ["@punctuation.bracket.typescript"] = { fg = colors.cyan },
  ["@punctuation.bracket.astro"] = { fg = colors.cyan },
  ["@punctuation.bracket.lua"] = { fg = colors.cyan },
  ["@punctuation.bracket.java"] = { fg = colors.cyan },
  ["@punctuation.bracket.swift"] = { fg = colors.cyan },
  ["@punctuation.bracket.go"] = { fg = colors.cyan },

  ["@text.uri.tsx"] = { fg = colors.none },
  ["@text.uri.vue"] = { fg = colors.none },
  ["@text.uri.javascript"] = { fg = colors.none },
  ["@text.uri.typescript"] = { fg = colors.none },
  ["@text.uri.html"] = { fg = colors.none },
  ["@text.uri.xml"] = { fg = colors.none },

  ["@variable.member.typescript"] = { fg = colors.red, link = "" },
  ["@variable.member.javascript"] = { fg = colors.red, link = "" },
  ["@variable.member.tsx"] = { fg = colors.red, link = "" },
  ["@variable.member.swift"] = { fg = colors.red, link = "" },

  ["@variable.rust"] = { fg = colors.red },
  ["@function.macro.rust"] = { fg = colors.blue },
  ["@namespace.rust"] = { fg = colors.orange },
  ["@variable.member.rust"] = { fg = colors.red, link = "" },
  ["@module.rust"] = { fg = colors.orange },
  ["@punctuation.bracket.rust"] = { fg = colors.cyan },

  ["@include.java"] = { fg = colors.magenta },
  ["@type.qualifier.java"] = { fg = colors.magenta },
  ["@repeat.java"] = { fg = colors.magenta },
  ["@attribute.java"] = { fg = colors.orange },
  ["@variable.member.java"] = { fg = colors.red, link = "" },

  htmlTag = { fg = colors.cyan },
  htmlEndTag = { fg = colors.cyan },
  htmlArg = { fg = colors.orange, link = "" },

  ["@variable.css"] = { fg = colors.red },
  ["@constant.bash"] = { fg = colors.red },

  zshVariable = { fg = colors.red },
  zshFunction = { fg = colors.blue },
  zshBrackets = { fg = colors.cyan },
  zshParentheses = { fg = colors.cyan },
  zshOperator = { fg = colors.cyan },
  zshDeref = { fg = colors.red },
  zshShortDeref = { fg = colors.red },
  zshSubst = { fg = colors.red },
  zshOldSubst = { fg = colors.red },
  zshDelimiter = { fg = colors.cyan },
  ["@variable.zsh"] = { fg = colors.red },
  ["@punctuation.bracket.zsh"] = { fg = colors.cyan },
  ["@punctuation.delimiter.zsh"] = { fg = colors.cyan },
  ["@operator.zsh"] = { fg = colors.cyan },

  ["@spell.gitcommit"] = { fg = colors.blue },
  ["@text.gitcommit"] = { fg = colors.cyan },

  LazyGitBorder = { fg = colors.blue },
  TabLine = { bg = colors.none, fg = colors.none },

  TextGreen = { fg = colors.green },
  TextRed = { fg = colors.red },
  TextBlue = { fg = colors.blue },
  TextMagenta = { fg = colors.magenta },
  TextYellow = { fg = colors.yellow },
  TextOrange = { fg = colors.orange },
  TextCyan = { fg = colors.cyan },

  WinbarEmpty = { bg = bg },
  CodeActionText = { fg = colors.white },

  IblIndent = { fg = colors.border },
  IblScope = { fg = colors.comment },
  ["@ibl.scope.underline.1"] = { underline = true },
  ["@ibl.scope.underline.2"] = { underline = true },
  ["@ibl.scope.underline.3"] = { underline = true },
  ["@ibl.scope.underline.4"] = { underline = true },
  ["@ibl.scope.underline.5"] = { underline = true },
  ["@ibl.scope.underline.6"] = { underline = true },
  ["@ibl.scope.underline.7"] = { underline = true },
  IndentBlanklineContextChar = { fg = colors.obsidian },
  IndentBlanklineIndent1 = { fg = colors.red, nocombine = true },
  IndentBlanklineIndent2 = { fg = colors.yellow, nocombine = true },
  IndentBlanklineIndent3 = { fg = colors.green, nocombine = true },
  IndentBlanklineIndent4 = { fg = colors.cyan, nocombine = true },
  IndentBlanklineIndent5 = { fg = colors.blue, nocombine = true },
  IndentBlanklineIndent6 = { fg = colors.magenta, nocombine = true },

  SkActive = { bg = colors.red, fg = colors.mode_fg },

  SnacksPickerListNormal = { bg = colors.none },
  SnacksPickerListNormalFloat = { bg = colors.none },
  SnacksPickerInputNormal = { bg = colors.none },
  SnacksPickerInputNormalFloat = { bg = colors.none },
  SnacksPickerDirectory = { fg = colors.white },
  SnacksPickerRoot = { fg = colors.red },
  Directory = { fg = colors.yellow },
  SnacksPickerTree = { fg = colors.border },

  GitSignsChange = { fg = colors.orange },
  GitSignsAdd = { fg = colors.green },
  GitSignsDelete = { fg = colors.red },

  LazyCommitIssue = { fg = colors.mustard },

  DiffAdd = { bg = "#2A304B", fg = colors.none },
  DiffDelete = { bg = "#34232C" },
  DiffChange = { bg = "#384268" },

  NoiceCmdlinePopupBorder = { fg = colors.lime },
  NoiceCmdLinePopupTitle = { fg = colors.lime },
  NoiceCmdlineIcon = { fg = colors.green },
  NoiceCmdlineBashIcon = { fg = colors.red },
  NoiceCmdlineHelpIcon = { fg = colors.blue },
  NoiceCmdlineHlIcon = { fg = colors.red },
  NoiceCmdlineReplaceIcon = { fg = colors.orange },
  NoiceCmdlineMapIcon = { fg = colors.white },
  NoiceCmdlineCalculatorIcon = { fg = colors.white },
  NoiceCmdlineLuaIcon = { link = "DevIconLua" },
  NoiceConfirmBorder = { fg = colors.green },
  NoicePopupmenuSelected = { bg = colors.blue, fg = colors.black },

  GitGraphHash = { fg = colors.yellow },
  GitGraphTimestamp = { fg = colors.green },
  GitGraphAuthor = { fg = colors.blue },
  GitGraphBranchName = { fg = colors.red },
  GitGraphBranchTag = { fg = colors.magenta },
  GitGraphBranchMsg = { fg = colors.white },
  GitGraphBranch1 = { fg = colors.red },
  GitGraphBranch2 = { fg = colors.orange },
  GitGraphBranch3 = { fg = colors.yellow },
  GitGraphBranch4 = { fg = colors.green },
  GitGraphBranch5 = { fg = colors.blue },

  qfLineNr = { fg = colors.yellow },

  NotifyERRORBorder = { fg = colors.maroon },
  NotifyWARNBorder = { fg = colors.mustard },
  NotifyINFOBorder = { fg = colors.forest },
  NotifyDEBUGBorder = { fg = colors.navy },
  NotifyTRACEBorder = { fg = colors.plum },
  NotifyERRORIcon = { fg = colors.red },
  NotifyWARNIcon = { fg = colors.yellow },
  NotifyINFOIcon = { fg = colors.green },
  NotifyDEBUGIcon = { fg = colors.blue },
  NotifyTRACEIcon = { fg = colors.magenta },
  NotifyERRORTitle = { fg = colors.red },
  NotifyWARNTitle = { fg = colors.yellow },
  NotifyINFOTitle = { fg = colors.green },
  NotifyDEBUGTitle = { fg = colors.blue },
  NotifyTRACETitle = { fg = colors.magenta },

  SnacksNotifierFooterInfo = { fg = colors.green },
  SnacksNotifierBorderInfo = { fg = colors.green },
  SnacksNotifierTitleInfo = { fg = colors.green },
  SnacksNotifierIconInfo = { fg = colors.green },

  SnacksPickerInput = { bg = bg },
  SnacksPickerList = { bg = bg },
  SnacksPickerPreview = { bg = bg },
  SnacksPickerBox = { bg = bg },
  SnacksPickerBorder = { fg = colors.obsidian, bg = bg },
  SnacksPickerInputBorder = { fg = colors.obsidian, bg = bg },
  SnacksPickerListBorder = { fg = colors.obsidian, bg = bg },
  SnacksPickerPreviewBorder = { fg = colors.obsidian, bg = bg },
  SnacksPickerBoxBorder = { fg = colors.obsidian, bg = bg },
  SnacksPickerMatch = { fg = colors.plum },
  SnacksPickerDir = { fg = colors.comment },
  SnacksPickerFile = { fg = colors.white },
  SnacksPickerPathHidden = { fg = colors.comment },
  SnacksPickerGitStatusAdded = { fg = colors.green },
  SnacksPickerGitStatusModified = { fg = colors.yellow },
  SnacksPickerGitStatusDeleted = { fg = colors.red },
  SnacksPickerGitStatusUntracked = { fg = colors.orange },
  SnacksPickerPrompt = { fg = colors.blue },

  LemonNormal = { bg = bg },
  LemonBorder = { fg = colors.float_border, bg = bg },
  LemonTitle = stl_style == "block" and { bg = colors.blue, fg = colors.black, bold = true }
    or { fg = colors.blue, bg = bg, bold = true },

  KulalaText = { bg = colors.green, fg = colors.black },

  LemonBeacon = { bg = colors.blue },
}

function M.apply(highlights)
  for name, opts in pairs(highlights) do
    if opts.link == "" then
      opts = vim.tbl_extend("force", opts, { link = nil })
    end
    vim.api.nvim_set_hl(0, name, opts)
  end
end

local function apply_all()
  M.apply(M.base)
  M.apply(M.syntax)
  M.apply(M.treesitter)
  M.apply(M.statusline)
  M.apply(M.dropbar)
  M.apply(M.diagnostics)
  M.apply(M.lsp)
  M.apply(M.lazy)
  M.apply(M.mason)
  M.apply(M.misc)
  M.apply(M.dashboard)
  M.apply(M.explorer)

  local ok_cmp, cmp_ui = pcall(require, "if.ui.cmp")
  if ok_cmp then
    if cmp_ui.override then
      M.apply(cmp_ui.override)
    end
    if cmp_ui.add then
      M.apply(cmp_ui.add)
    end
  end

  M.apply(M.plugins)
end

function M.setup()
  apply_all()
  M.set_terminal_colors()
end

function M.set_terminal_colors()
  vim.g.terminal_color_0 = colors.black
  vim.g.terminal_color_1 = colors.red
  vim.g.terminal_color_2 = colors.green
  vim.g.terminal_color_3 = colors.yellow
  vim.g.terminal_color_4 = colors.blue
  vim.g.terminal_color_5 = colors.magenta
  vim.g.terminal_color_6 = colors.cyan
  vim.g.terminal_color_7 = colors.white
  vim.g.terminal_color_8 = colors.charcoal
  vim.g.terminal_color_9 = colors.peach
  vim.g.terminal_color_10 = colors.lime
  vim.g.terminal_color_11 = colors.lemon
  vim.g.terminal_color_12 = colors.sky
  vim.g.terminal_color_13 = colors.lavender
  vim.g.terminal_color_14 = colors.aqua
  vim.g.terminal_color_15 = colors.ivory
end

return M
