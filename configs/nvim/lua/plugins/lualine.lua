return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local lualine = require('lualine')
        lualine.setup({
            options = {
                icons_enabled = true,
                component_separators = "",
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
                lualine_y = { 'diagnostics' },
                lualine_z = { 'progress', { 'location' } }
            },
        })
    end
}
