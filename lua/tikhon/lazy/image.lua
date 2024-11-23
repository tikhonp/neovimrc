return {
    "3rd/image.nvim",
    event = "VeryLazy",
    dependecies = {
        -- brew install imagemagick pkg-config
        -- on macos
        {
            "vhyrro/luarocks.nvim",
            opts = {
                rocks = { "magick" },
            },
        },
    },
    opts = {
        integrations = {
            backend = "kitty",
            markdown = {
                enabled = true,
                clear_in_insert_mode = false,
                download_remote_images = true,
                only_render_image_at_cursor = false,
                filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
            },
        },
        max_height_window_percentage = 70,
        window_overlap_clear_enabled = true,
        tmux_show_only_in_active_window = true,
        editor_only_render_when_focused = true,
    }
}
