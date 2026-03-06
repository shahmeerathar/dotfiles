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
        daily_notes = {
            template = "Templates/Daily Note.md"
        },
        note_id_func = (function(title)
            return title
        end),
        checkbox = {
            create_new = false,
            order = { " ", "x" },
        },
        templates = {
            folder = "Templates",
        },
    },
    vim.keymap.set("n", "<leader>ot", "<cmd>Obsidian today<CR>"),
    vim.keymap.set("n", "<leader>od", "<cmd>Obsidian dailies<CR>"),
    vim.keymap.set("n", "<leader>of", "<cmd>Obsidian quick_switch<CR>"),
    vim.keymap.set("n", "<leader>os", "<cmd>Obsidian search<CR>"),
    vim.keymap.set("n", "<leader>ow", function()
        local year = tonumber(os.date("%Y"))
        local week = tonumber(os.date("%V"))
        local title = string.format("%d-W%02d", year, week)
        local path = vim.fn.expand("~/Notes/") .. title .. ".md"
        if vim.fn.filereadable(path) == 1 then
            vim.cmd("edit " .. vim.fn.fnameescape(path))
        else
            vim.cmd({ cmd = "Obsidian", args = { "new_from_template", title, "Weekly Note.md" } })
        end
    end, { desc = "Obsidian weekly" }),
    enabled = vim.loop.os_uname().sysname == "Darwin",
}
