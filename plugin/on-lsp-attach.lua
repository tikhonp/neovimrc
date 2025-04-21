local remap_lsp_group = vim.api.nvim_create_augroup("RemapLsp", {})
vim.api.nvim_create_autocmd("LspAttach", {
    group = remap_lsp_group,
    callback = function(e)
        local format_on_save_group = vim.api.nvim_create_augroup("formatOnSave", {})
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = format_on_save_group,
            buffer = e.buf,
            callback = vim.lsp.buf.format,
        })

        local remap_opts = { buffer = e.buf }

        -- i map it to C-h because C-s is used for snippets
        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, remap_opts)

        -- soooooo C-] is strange isnt it?
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, remap_opts)

        vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, remap_opts)

        vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, remap_opts)
        vim.keymap.set("n", "]d", function()
            vim.diagnostic.jump({ count = 1, float = true })
        end, remap_opts)
        vim.keymap.set("n", "[d", function()
            vim.diagnostic.jump({ count = -1, float = true })
        end, remap_opts)
    end
})
