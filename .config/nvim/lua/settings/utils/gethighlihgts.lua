local function print_highlight_groups(groups)
	local function get_highlight(group)
		local hl = vim.api.nvim_get_hl(0, { name = group })
		local result = {
			fg = hl.fg and string.format("#%06x", hl.fg) or "none",
			bg = hl.bg and string.format("#%06x", hl.bg) or "none",
			sp = hl.sp and string.format("#%06x", hl.sp) or "none",
			link = hl.link and string.format("%s", hl.link) or "none",
		}
		return result
	end

	for _, group in ipairs(groups) do
		local hl = get_highlight(group)
		vim.print(string.format("%-30s fg: %-10s bg: %-10s sp: %-10s %-20s", group, hl.fg, hl.bg, hl.sp, hl.link))
	end
end

local syntax_group = {
	"@lsp",
	"@lsp.type.class",
	"@lsp.type.comment",
	"@lsp.type.decorator",
	"@lsp.type.enum",
	"@lsp.type.enumMember",
	"@lsp.type.event",
	"@lsp.type.function",
	"@lsp.type.interface",
	"@lsp.type.keyword",
	"@lsp.type.macro",
	"@lsp.type.method",
	"@lsp.type.modifier",
	"@lsp.type.namespace",
	"@lsp.type.number",
	"@lsp.type.operator",
	"@lsp.type.parameter",
	"@lsp.type.property",
	"@lsp.type.regexp",
	"@lsp.type.string",
	"@lsp.type.struct",
	"@lsp.type.type",
	"@lsp.type.typeParameter",
	"@lsp.type.variable",
	"@lsp.mod.abstract",
	"@lsp.mod.async",
	"@lsp.mod.declaration",
	"@lsp.mod.defaultLibrary",
	"@lsp.mod.definition",
	"@lsp.mod.deprecated",
	"@lsp.mod.documentation",
	"@lsp.mod.modification",
	"@lsp.mod.readonly",
	"@lsp.mod.static",
	"LspCodeLens",
	"LspCodeLensSeparator",
	"LspInlayHint",
	"LspReferenceRead",
	"LspReferenceText",
	"LspReferenceWrite",
	"LspSignatureActiveParameter",
	"@variable",
	"@variable.builtin",
	"@variable.parameter",
	"@variable.parameter.builtin",
	"@variable.member",
	"@constant",
	"@constant.builtin",
	"@constant.macro",
	"@module",
	"@module.builtin",
	"@label",
	"@string",
	"@string.documentation",
	"@string.regexp",
	"@string.escape",
	"@string.special",
	"@string.special.symbol",
	"@string.special.path",
	"@string.special.url",
	"@character",
	"@character.special",
	"@boolean",
	"@number",
	"@number.float",
	"@type",
	"@type.builtin",
	"@type.definition",
	"@attribute",
	"@attribute.builtin",
	"@property",
	"@function",
	"@function.builtin",
	"@function.call",
	"@function.macro",
	"@function.method",
	"@function.method.call",
	"@constructor",
	"@operator",
	"@keyword",
	"@keyword.coroutine",
	"@keyword.function",
	"@keyword.operator",
	"@keyword.import",
	"@keyword.type",
	"@keyword.modifier",
	"@keyword.repeat",
	"@keyword.return",
	"@keyword.debug",
	"@keyword.exception",
	"@keyword.conditional",
	"@keyword.conditional.ternary",
	"@keyword.directive",
	"@keyword.directive.define",
	"@punctuation.delimiter",
	"@punctuation.bracket",
	"@punctuation.special",
	"@comment",
	"@comment.documentation",
	"@comment.error",
	"@comment.warning",
	"@comment.todo",
	"@comment.note",
	"@markup.strong",
	"@markup.italic",
	"@markup.strikethrough",
	"@markup.underline",
	"@markup.heading",
	"@markup.heading.1",
	"@markup.heading.2",
	"@markup.heading.3",
	"@markup.heading.4",
	"@markup.heading.5",
	"@markup.heading.6",
	"@markup.quote",
	"@markup.math",
	"@markup.link",
	"@markup.link.label",
	"@markup.link.url",
	"@markup.raw",
	"@markup.raw.block",
	"@markup.list",
	"@markup.list.checked",
	"@markup.list.unchecked",
	"@diff.plus",
	"@diff.minus",
	"@diff.delta",
	"@tag",
	"@tag.builtin",
	"@tag.attribute",
	"@tag.delimiter",
	"Comment",
	"Constant",
	"String",
	"Character",
	"Number",
	"Boolean",
	"Float",
	"Identifier",
	"Function",
	"Statement",
	"Conditional",
	"Repeat",
	"Label",
	"Operator",
	"Keyword",
	"Exception",
	"PreProc",
	"Include",
	"Define",
	"Macro",
	"PreCondit",
	"Type",
	"StorageClass",
	"Structure",
	"Typedef",
	"Special",
	"SpecialChar",
	"Tag",
	"Delimiter",
	"SpecialComment",
	"Debug",
	"Underlined",
	"Ignore",
	"Error",
	"Todo",
	"Added",
	"Changed",
	"Removed",
}
local base_group = {
	"ColorColumn",
	"Conceal",
	"CurSearch",
	"Cursor",
	"lCursor",
	"CursorIM",
	"CursorColumn",
	"CursorLine",
	"Directory",
	"DiffAdd",
	"DiffChange",
	"DiffDelete",
	"DiffText",
	"EndOfBuffer",
	"TermCursor",
	"TermCursorNC",
	"ErrorMsg",
	"WinSeparator",
	"Folded",
	"FoldColumn",
	"SignColumn",
	"IncSearch",
	"Substitute",
	"LineNr",
	"LineNrAbove",
	"LineNrBelow",
	"CursorLineNr",
	"contains",
	"CursorLineFold",
	"CursorLineSign",
	"MatchParen",
	"ModeMsg",
	"MsgArea",
	"MsgSeparator",
	"MoreMsg",
	"NonText",
	"Normal",
	"NormalFloat",
	"FloatBorder",
	"FloatTitle",
	"FloatFooter",
	"NormalNC",
	"Pmenu",
	"PmenuSel",
	"PmenuKind",
	"PmenuKindSel",
	"PmenuExtra",
	"PmenuExtraSel",
	"PmenuSbar",
	"PmenuThumb",
	"PmenuMatch",
	"PmenuMatchSel",
	"Question",
	"QuickFixLine",
	"Search",
	"SnippetTabstop",
	"SpecialKey",
	"SpellBad",
	"SpellCap",
	"SpellLocal",
	"SpellRare",
	"StatusLine",
	"StatusLineNC",
	"StatusLineTerm",
	"StatusLineTermNC",
	"TabLine",
	"TabLineFill",
	"TabLineSel",
	"Title",
	"Visual",
	"VisualNOS",
	"WarningMsg",
	"Whitespace",
	"WildMenu",
	"WinBar",
	"WinBarNC",
	"Menu",
	"Scrollbar",
	"Tooltip",
	"FloatShadow",
	"FloatShadowThrough",
	"RedrawDebugClear",
	"RedrawDebugComposed",
	"RedrawDebugNormal",
	"RedrawDebugRecompose",
}

vim.api.nvim_create_user_command('Gethighlightbase',
	function()
		print_highlight_groups(base_group)
	end,
	{
		desc = 'Get highlight groups info',
	}
)

vim.api.nvim_create_user_command('Gethighlightsyntax',
	function()
		print_highlight_groups(syntax_group)
	end,
	{
		desc = 'Get highlight groups info',
	}
)