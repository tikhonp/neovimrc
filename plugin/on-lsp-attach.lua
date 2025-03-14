---@param bufnr integer
---@param mode "v"|"V"
---@return table {start={row,col}, end={row,col}} using (1, 0) indexing
local function range_from_selection(bufnr, mode)
    -- [bufnum, lnum, col, off]; both row and column 1-indexed
    local start = vim.fn.getpos('v')
    local end_ = vim.fn.getpos('.')
    local start_row = start[2]
    local start_col = start[3]
    local end_row = end_[2]
    local end_col = end_[3]

    -- A user can start visual selection at the end and move backwards
    -- Normalize the range to start < end
    if start_row == end_row and end_col < start_col then
        end_col, start_col = start_col, end_col
    elseif end_row < start_row then
        start_row, end_row = end_row, start_row
        start_col, end_col = end_col, start_col
    end
    if mode == 'V' then
        start_col = 1
        local lines = vim.api.nvim_buf_get_lines(bufnr, end_row - 1, end_row, true)
        end_col = #lines[1]
    end
    return {
        ['start'] = { start_row, start_col - 1 },
        ['end'] = { end_row, end_col - 1 },
    }
end

local lsp_buf_format = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local mode = vim.api.nvim_get_mode().mode
    local range ---@type {start:[integer,integer],end:[integer, integer]}|{start:[integer,integer],end:[integer,integer]}[]
    if not range and mode == 'v' or mode == 'V' then
        range = range_from_selection(bufnr, mode)
    end

    local ms = require('vim.lsp.protocol').Methods
    local passed_multiple_ranges = (range and #range ~= 0 and type(range[1]) == 'table')
    local method ---@type string
    if passed_multiple_ranges then
        method = ms.textDocument_rangesFormatting
    elseif range then
        method = ms.textDocument_rangeFormatting
    else
        method = ms.textDocument_formatting
    end

    local clients = vim.lsp.get_clients({
        bufnr = vim.api.nvim_get_current_buf(),
        method = method,
    })
    if #clients == 0 then
        -- no matching language servers
        return
    end
    if vim.bo.filetype == "templ" then
        local filename = vim.api.nvim_buf_get_name(bufnr)
        local cmd = "templ fmt " .. vim.fn.shellescape(filename)
        vim.fn.jobstart(cmd, {
            on_exit = function()
                -- Reload the buffer only if it's still the current buffer
                if vim.api.nvim_get_current_buf() == bufnr then
                    vim.cmd('e!')
                end
            end,
        })
    else
        vim.lsp.buf.format()
    end
end

local remap_lsp_group = vim.api.nvim_create_augroup("RemapLsp", {})
vim.api.nvim_create_autocmd("LspAttach", {
    group = remap_lsp_group,
    callback = function(e)
        local opts = { buffer = e.buf }

        local format_on_save_group = vim.api.nvim_create_augroup("formatOnSave", {})
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = format_on_save_group,
            buffer = e.buf,
            callback = lsp_buf_format,
        })

        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
        vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>f", lsp_buf_format, { desc = "Format current buffer" })

        vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    end
})
