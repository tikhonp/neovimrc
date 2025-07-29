return {

    "neovim/nvim-lspconfig",

    dependencies = {
        "L3MON4D3/LuaSnip",
        {
            "j-hui/fidget.nvim",

            -- waiting for https://github.com/j-hui/fidget.nvim/issues/282 fix
            commit = "e4e71e915b2eb28126262f9591853929c9974400",

            opts = {},
        },
        {
            "saghen/blink.cmp",
            opts = {
                completion = {
                    menu = {
                        border = "rounded",
                        draw = {
                            columns = { { "label", "label_description", gap = 1 }, { "kind" } },
                        }
                    },
                    documentation = {
                        auto_show = true,
                        window = { winhighlight = "Normal:Normal,FloatBorder:FloatBorder" },
                    },
                },
                fuzzy = { implementation = "lua" }
            },
        },
        {
            "folke/lazydev.nvim",
            ft = "lua",
            opts = true,
        },
    },

    event = "VeryLazy",

    config = function()
        vim.lsp.enable({
            "lua_ls",
            "templ",
            "pylsp",
            "bashls",
            "clangd",
            "gopls",
        })
        vim.keymap.set("n", "<leader>lr", "<cmd>LspRestart<CR>", { desc = "[L]sp [R]estart" })
    end,
}
