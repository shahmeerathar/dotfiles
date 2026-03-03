return {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    event = {
        "BufReadPre /Users/shahmeerathar/Notes/*.md",
        "BufNewFile /Users/shahmeerathar/Notes/*.md",
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        'nvim-telescope/telescope.nvim',
        "hrsh7th/nvim-cmp",
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {
        workspaces = {
            {
                name = "Notes",
                path = "/Users/shahmeerathar/Notes",
            },
        },
        completion = {
            nvim_cmp = true,
            min_chars = 2,
        },
        disable_frontmatter = true,
    },
    enabled = vim.loop.os_uname().sysname == "Darwin",
}
