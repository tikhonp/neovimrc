return {

    "github/copilot.vim",

    config = function()
        local proxy_server = os.getenv("MY_PROXY_SERVER")
        if (proxy_server == nil) then
            print("Environment variable MY_PROXY_SERVER not set")
            return
        end
        vim.g.copilot_proxy = proxy_server

        vim.keymap.set("n", "<leader>cp", "<cmd>Copilot panel<CR>", { desc = "Open [C]opilot [P]anel" })
    end,

}
