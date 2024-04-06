require("tikhon.set")
require("tikhon.remap")
require("tikhon.lazy_init")

vim.filetype.add({
    extension = {
        templ = "templ",
    }
})

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local yank_group = augroup("HighlightYank", {})
autocmd("TextYankPost", {
    group = yank_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 100,
        })
    end,
})

local remap_lsp_group = augroup("RemapLsp", {})
local format_on_save_group = augroup("formatOnSave", {})
autocmd("LspAttach", {
    group = remap_lsp_group,
    callback = function(e)
        local opts = { buffer = e.buf }

        autocmd("BufWritePre", {
            group = format_on_save_group,
            buffer = e.buf,
            callback = function()
                vim.lsp.buf.format()
            end,
        })

        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
        vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format current buffer" })

        vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
    end
})
