return {

    "nvim-treesitter/nvim-treesitter",

    build = ":TSUpdate",

    opts = {
        ensure_installed = { "sql", "javascript", "typescript", "bash", "html", "lua", "markdown", "vim", "vimdoc", "go" },
        sync_install = false,
        auto_install = true,
        indent = {
            enable = true
        },
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = { "markdown" },
        },
    },

    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)

        vim.filetype.add({ extension = { templ = "templ" } })

        local treesitter_parser_config = require("nvim-treesitter.parsers").get_parser_configs()
        treesitter_parser_config.templ = {
            install_info = {
                url = "https://github.com/vrischmann/tree-sitter-templ.git",
                files = { "src/parser.c", "src/scanner.c" },
                branch = "master",
            },
        }

        vim.treesitter.language.register("templ", "templ")

        vim.opt.foldtext = 'v:lua.vim.treesitter.foldtext()'
    end,

}
