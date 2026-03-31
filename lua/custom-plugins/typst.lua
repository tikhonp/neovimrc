return {
    'chomosuke/typst-preview.nvim',
    lazy = false,
    version = '1.*',
    keys = {
        { "<leader>tp", "<cmd>TypstPreview<CR>", "n" },
        { "<leader>tt", "<cmd>TypstPreviewSyncCursor<CR>", "n"}
    },
    opts = {
        open_cmd = 'google-chrome-stable --app=%s',
        -- invert_colors = 'auto',
    },
}
