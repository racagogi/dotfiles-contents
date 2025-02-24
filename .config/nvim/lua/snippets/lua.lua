local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node

return {
	s("(", { t("("), i(1, " "), t(")") }),
	s("{", { t("{"), i(1, " "), t("}") }),
	s("[", { t("["), i(1, " "), t("]") }),
	s("\"", { t("\""), i(1, " "), t("\"") }),
	s("'", { t("'"), i(1, " "), t("'") }),
	s("`", { t("`"), i(1, " "), t("`") }),
}
