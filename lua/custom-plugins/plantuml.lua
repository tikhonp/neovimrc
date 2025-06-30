return {
    "weirongxu/plantuml-previewer.vim",
    dependencies = {
        "tyru/open-browser.vim",
        "aklt/plantuml-syntax",
    },
    keys = {
        { "<leader>pu", "<cmd>PlantumlOpen<CR>", "n" },
    },
    lazy = false,
}
