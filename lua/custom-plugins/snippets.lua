return {

    "L3MON4D3/LuaSnip",

    version = "v2.*",

    build = "make install_jsregexp",

    dependencies = { "rafamadriz/friendly-snippets" },

    event = "InsertEnter",

    config = function()
        require("luasnip.loaders.from_lua").lazy_load({ paths={ "./snippets/"}})

        local ls = require("luasnip")

        vim.keymap.set({ "i", "s" }, "<C-s>;", function() ls.jump(1) end, { silent = true })
        vim.keymap.set({ "i", "s" }, "<C-s>,", function() ls.jump(-1) end, { silent = true })
    end,

}
