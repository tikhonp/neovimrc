return {

    "rose-pine/neovim",

    lazy = false,

    priority = 1000,

    config = function()
        require('rose-pine').setup({
            styles = {
                transparency = true,
            },
        })

        vim.cmd.colorscheme("rose-pine")

        -- make background transparent to make it always black
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end

}
