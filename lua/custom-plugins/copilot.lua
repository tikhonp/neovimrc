return {

    "github/copilot.vim",

    keys = {
        { "<leader>cp", "<cmd>Copilot panel<CR>", "n" },
        { "<leader>ce", function()
            vim.cmd("Copilot enable")
            vim.notify("[Copilot] Enabled")
        end, "n" },
        { "<leader>cd", function()
            vim.cmd("Copilot disable")
            vim.notify("[Copilot] Disabled")
        end, "n" },
    },

    config = function()
        local proxy_server = os.getenv("MY_PROXY_SERVER")
        if (proxy_server == nil) then
            vim.notify("[Copilot] Environment variable MY_PROXY_SERVER not set", vim.log.levels.WARN)
            return
        end
        vim.g.copilot_proxy = proxy_server
    end,

}
