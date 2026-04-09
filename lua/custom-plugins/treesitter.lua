return {

    "nvim-treesitter/nvim-treesitter",

    build = ":TSUpdate",

    branch = "main",

    lazy = false,

    config = function()
        require('nvim-treesitter').install {
            "sql", "javascript", "typescript",
            "bash", "html", "lua", "markdown",
            "vim", "vimdoc", "go", "templ",
            "gitcommit", "gitignore", "gitattributes", "git_rebase",
            "git_config", "python", "dockerfile", "yaml",
        }

        vim.opt.foldtext = 'v:lua.vim.treesitter.foldtext()'

        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

        local group = vim.api.nvim_create_augroup("custom-treesitter", { clear = true })
        vim.api.nvim_create_autocmd("FileType", {
            group = group,
            callback = function(args)
                local bufnr = args.buf
                local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
                if not ok or not parser then
                    return
                end
                pcall(vim.treesitter.start)
            end,
        })
    end,
}
