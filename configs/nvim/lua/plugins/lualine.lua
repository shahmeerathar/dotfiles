return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local lualine = require('lualine')

        local clangd_index_percent = nil

        vim.api.nvim_create_autocmd('LspProgress', {
            callback = function(ev)
                local client = vim.lsp.get_client_by_id(ev.data.client_id)
                if not client or client.name ~= 'clangd' then
                    return
                end

                local value = ev.data.params.value
                if value.title == 'indexing' then
                    clangd_index_percent = (value.kind ~= 'end') and value.percentage or nil
                    lualine.refresh({ place = { 'statusline' } })
                end
            end,
        })

        local function clangd_indexing()
            if clangd_index_percent == nil then
                return ''
            end
            return string.format('clangd indexing: %d%%%%', clangd_index_percent)
        end

        lualine.setup({
            options = {
                icons_enabled = true,
                component_separators = "",
                section_separators = "",
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                always_show_tabline = true,
                globalstatus = true,
                refresh = {
                    statusline = 100,
                    tabline = 100,
                    winbar = 100,
                }
            },
            sections = {
                lualine_a = { { 'mode' } },
                lualine_b = { 'branch', 'diff' },
                lualine_c = { 'windows' },
                lualine_x = { 'searchcount', 'selectioncount', "filetype" },
                lualine_y = { 'diagnostics', clangd_indexing },
                lualine_z = { 'progress', { 'location' } }
            },
        })
    end
}
