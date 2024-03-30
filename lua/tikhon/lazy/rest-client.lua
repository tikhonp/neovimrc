return {

    "rest-nvim/rest.nvim",

    dependencies = {
        {
            "vhyrro/luarocks.nvim",
            config = true,
        },
    },

    config = function()
        require("rest-nvim").setup()

        vim.keymap.set("n", "<leader>rr", "<cmd>Rest run<cr>", { desc = "[R]un [R]equest under the cursor" })
    end,

}
