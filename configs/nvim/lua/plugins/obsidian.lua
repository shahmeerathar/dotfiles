return {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    ---@module 'obsidian'
    ---@type obsidian.config
    dependencies = {
        "folke/snacks.nvim",
        "hrsh7th/nvim-cmp",
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {
        legacy_commands = false,
        frontmatter = {
            enabled = false,
        },
        note = {
            template = "Templates/Default.md"
        },
        workspaces = {
            {
                name = "Notes",
                path = "~/Notes",
            },
        },
        note_id_func = (function(title)
            return title
        end),
        checkbox = {
            create_new = false,
            order = { " ", "x" },
        },
    },
    vim.keymap.set("n", "<leader>ot", "<cmd>Obsidian today<CR>"),
    vim.keymap.set("n", "<leader>od", "<cmd>Obsidian dailies<CR>"),
    vim.keymap.set("n", "<leader>of", "<cmd>Obsidian quick_switch<CR>"),
    vim.keymap.set("n", "<leader>os", "<cmd>Obsidian search<CR>"),
    enabled = vim.loop.os_uname().sysname == "Darwin",
}
