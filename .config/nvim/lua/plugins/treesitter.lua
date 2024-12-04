return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local config = require("nvim-treesitter.configs")
        require 'nvim-treesitter.install'.compilers = { "clang" }
        config.setup({
            ensure_installed = { "lua", "cpp", "python" }, 
            highlight = { enable = true },
            indent = { enable = true }
        })
    end
}
