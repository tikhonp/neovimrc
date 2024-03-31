return {

    "diepm/vim-rest-console",

    config = function()
        vim.g.vrc_set_default_mapping = 0
        vim.g.vrc_split_request_body = 1

        vim.g.vrc_curl_opts = {
            [ "--silent" ] = "",
            [ "--include" ] = "",
            [ "--compressed" ] = "",
        }

        vim.g.vrc_auto_format_response_patterns = {
            json = "jq",
            html = "tidy -i -q --tidy-mark no --show-body-only auto --show-errors 0 --show-warnings 0 -",
            xml = "tidy -xml -i -q --tidy-mark no --show-body-only auto --show-errors 0 --show-warnings 0 -",
        }

        vim.keymap.set("n", "<leader>rr", "<cmd>call VrcQuery ()<CR>", { desc = "[R]un [R]equest under the cursor" })
    end

}
