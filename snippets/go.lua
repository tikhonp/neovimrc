local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
    s({ trig = "iferr" }, {
        t({ "if err != nil {", "\treturn ", }),
        i(1, "err"),
        t({ "", "}" }),
    }),
}
