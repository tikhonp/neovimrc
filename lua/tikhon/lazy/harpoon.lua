return {

    "ThePrimeagen/harpoon",

    branch = "harpoon2",

    dependencies = { "nvim-lua/plenary.nvim" },

    config = function()
        local harpoon = require("harpoon")

        harpoon:setup()

        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)

        local toggle_opts = {
            border = "rounded",
            title_pos = "center",
            ui_width_ratio = 0.40,
        }
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list(), toggle_opts) end)

        for i = 1, 8 do
            vim.keymap.set("n", string.format("<space>%d", i), function() harpoon:list():select(i) end)
            vim.keymap.set("n", string.format("<A-%d>", i), function() harpoon:list():select(i) end)
        end
    end,

}
