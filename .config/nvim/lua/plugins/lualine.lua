return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local lualine = require('lualine')
        lualine.setup({
            options = {
                icons_enabled = true,
                theme = 'catppuccin',
                component_separators = "",
                section_separators = { left = "", right = "" },
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
                lualine_a = { { 'mode', separator = { left = "", right = "" } } },
                lualine_b = {'branch', 'diff'},
                lualine_c = {'windows'},
                lualine_x = {'searchcount', 'selectioncount', "filetype"},
                lualine_y = {'diagnostics'},
                lualine_z = {'progress', { 'location' , separator = { left = "", right = "" } } }
            },
        })
    end
}
