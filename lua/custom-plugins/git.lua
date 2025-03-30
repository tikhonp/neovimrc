return {
    {
        "tpope/vim-fugitive",

        keys = {
            { "<leader>gf", vim.cmd.Git, "n" },
        },

        config = function()
            local tikhon_fugitive_group = vim.api.nvim_create_augroup("tikhon_fugitive_group", {})
            vim.api.nvim_create_autocmd("BufWinEnter", {
                group = tikhon_fugitive_group,
                pattern = "*",
                callback = function()
                    if vim.bo.ft ~= "fugitive" then
                        return
                    end

                    local bufnr = vim.api.nvim_get_current_buf()
                    local opts = { buffer = bufnr, remap = false }

                    vim.keymap.set("n", "<leader>p", function()
                        vim.cmd.Git("gigapush")
                    end, opts)

                    vim.keymap.set("n", "<leader>P", function()
                        vim.cmd.Git("push")
                    end, opts)

                    vim.keymap.set("n", "<leader>h", function()
                        vim.cmd.Git("hub")
                    end, opts)

                    vim.keymap.set("n", "<leader>l", function()
                        vim.cmd.Git("lab")
                    end, opts)
                end,
            })
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            on_attach = function(bufnr)
                local gitsigns = require("gitsigns")

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                map("n", "<leader>gx", gitsigns.reset_hunk)
                map("n", "<leader>gg", gitsigns.preview_hunk_inline)
            end,
        },
    },
}
