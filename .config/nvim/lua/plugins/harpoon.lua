return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon add" })
        vim.keymap.set("n", "<leader>hl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
            { desc = "Harpoon list" })
        vim.keymap.set("n", "<C-M-p>", function() harpoon:list():prev() end, { desc = "Harpoon previous" })
        vim.keymap.set("n", "<C-M-n>", function() harpoon:list():next() end, { desc = "Harpoon next" })

        for _, idx in ipairs { 1, 2, 3, 4, 5, 6, 7, 8, 9 } do
            vim.keymap.set("n", string.format("<leader>%d", idx), function()
                harpoon:list():select(idx)
            end, { desc = string.format("Harpoon jump to %d", idx) })
            vim.keymap.set("n", string.format("<leader>v%d", idx), function()
                harpoon:list():select(idx, { vsplit = true })
            end, { desc = string.format("Harpoon jump to %d in new vertical split", idx) })
        end

        harpoon:extend({
            UI_CREATE = function(cx)
                vim.keymap.set("n", "<C-v>", function()
                    harpoon.ui:select_menu_item({ vsplit = true })
                end, { buffer = cx.bufnr })

                vim.keymap.set("n", "<C-x>", function()
                    harpoon.ui:select_menu_item({ split = true })
                end, { buffer = cx.bufnr })

                vim.keymap.set("n", "<C-t>", function()
                    harpoon.ui:select_menu_item({ tabedit = true })
                end, { buffer = cx.bufnr })
            end,
        })
    end
}
