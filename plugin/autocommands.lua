local yank_group = vim.api.nvim_create_augroup("HighlightYank", {})
vim.api.nvim_create_autocmd("TextYankPost", {
    group = yank_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 100,
        })
    end,
})

local two_spaces_identaiton = vim.api.nvim_create_augroup("TwoSpacesIndentation", {})
vim.api.nvim_create_autocmd("FileType", {
    group = two_spaces_identaiton,
    pattern = "json,html,xml,yaml",
    callback = function()
        vim.bo.tabstop = 2
        vim.bo.softtabstop = 2
        vim.bo.shiftwidth = 2
    end,
})
