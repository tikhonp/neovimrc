return {
    'chomosuke/typst-preview.nvim',
    lazy = false,
    version = '1.*',
    keys = {
        { "<leader>tp", "<cmd>TypstPreview<CR>", "n" },
        { "<leader>tt", "<cmd>TypstPreviewSyncCursor<CR>", "n"}
    },
    opts = {
        open_cmd = os.getenv("TYPST_BROWSER_OPEN_CMD") or nil,
        -- invert_colors = 'auto',
    },
}
