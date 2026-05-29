return {
    "develmusa/strudel.nvim",
    branch = "fix-nodejs-v25-yargs",
    build = "npm ci",
    config = function()
        require("strudel").setup({
            update_on_save = true,
            browser_exec_path = "/usr/bin/google-chrome-stable",
        })

        local strudel = require("strudel")

        vim.keymap.set("n", "<leader>sl", strudel.launch, { desc = "Launch Strudel" })
        vim.keymap.set("n", "<leader>sq", strudel.quit, { desc = "Quit Strudel" })
        vim.keymap.set("n", "<leader>st", strudel.toggle, { desc = "Strudel Toggle Play/Stop" })
    end,
}
