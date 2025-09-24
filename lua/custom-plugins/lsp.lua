return {

    "neovim/nvim-lspconfig",

    dependencies = {
        "L3MON4D3/LuaSnip",
        { "j-hui/fidget.nvim", opts = {} },
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
                        window = { border = "rounded", winhighlight = "Normal:Normal,FloatBorder:FloatBorder" },
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
        -- disable lsp on .env files
        vim.filetype.add({ filename = { [".env"] = "dotenv" } })

        vim.diagnostic.config {
            float = { border = "rounded" },
            virtual_text = true,
        }
        local hover = vim.lsp.buf.hover
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.lsp.buf.hover = function()
            return hover({
                border = "rounded",
            })
        end

        vim.keymap.set("n", "<leader>lr", "<cmd>LspRestart<CR>", { desc = "[L]sp [R]estart" })

        vim.lsp.enable({
            "lua_ls",
            "templ",
            "pylsp",
            "bashls",
            "clangd",
            "gopls",
            "pylsp",
        })

        vim.lsp.config('gopls', {
            settings = {
                gopls = {
                    analyses = {
                        unusedresult = true,
                        unusedvariable = true,
                    },
                    staticcheck = true,
                },
            },
        })
        vim.lsp.config('pylsp', {
            settings = {
                pylsp = {
                    plugins = {
                        pycodestyle = {
                            ignore = { 'W292', 'E501', },
                            maxLineLength = 100
                        },
                    },
                },
            },
        })
        vim.lsp.config('clangd', {
            cmd = { "clangd", "--query-driver=/Users/tikhon/.espressif/tools/riscv32-esp-elf/esp-14.2.0_20241119/riscv32-esp-elf/bin/riscv32-esp-elf-gcc" },
        })
    end,
}
