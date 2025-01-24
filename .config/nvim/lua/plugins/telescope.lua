return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        'nvim-tree/nvim-web-devicons'
    },
    config = function()
        local builtin = require('telescope.builtin')
        require('telescope').load_extension('fzf')
        vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = "Telescope find files" })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Telescope view open buffers" })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Telescope live grep" })
        vim.keymap.set('n', '<leader>fw', function()
            builtin.grep_string({ search = vim.fn.expand('<cword>') })
        end, { desc = "Telescope grep word" })
        vim.keymap.set('n', '<leader>fW', function()
            builtin.grep_string({ search = vim.fn.expand('<cWORD>') })
        end, { desc = "Telescope grep WORD" })
        vim.keymap.set('n', '<leader>fs', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end, { desc = "Telescope grep string" })
    end
}
