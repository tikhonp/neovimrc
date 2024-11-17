return {
    "puremourning/vimspector",
    lazy = true,
    opts = {},
    config = true,
    keys = {
        { "<leader>vdd", "<cmd>call vimspector#Launch()<CR>", "n" },
        { "<leader>vdr", "<cmd>call vimspector#Reset()<CR>",  "n" },
    }
}

