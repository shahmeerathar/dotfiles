return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "vtsls" }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT'
                        },
                        diagnostics = {
                            globals = { 'vim' },
                        },
                        workspace = {
                            library = {
                                vim.env.VIMRUNTIME,
                            }
                        }
                    }
                }
            })
            lspconfig.clangd.setup({
                capabilities = capabilities,
                cmd = {
                    "clangd",
                    "--header-insertion=never",
                    "--fallback-style=webkit"
                }
            })
            lspconfig.vtsls.setup({ capabilities = capabilities })

            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP actions',
                callback = function(event)
                    local opts = { buffer = event.buf }

                    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                    vim.keymap.set('n', '<leader>cr', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                    vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if not client then
                        return
                    end

                    local formatting_func = function()
                        vim.cmd('lua vim.lsp.buf.format()')
                    end

                    local lsp_name = client.name
                    opts.desc = "vim.lsp.buf.format()"
                    vim.keymap.set('n', '<leader>cf', formatting_func, opts)

                    if (not ((lsp_name == 'pylsp' or lsp_name == 'clangd') and vim.fn.getenv("HOSTNAME") == "shahmeera-dev")) then
                        vim.api.nvim_create_autocmd('BufWritePre', {
                            buffer = event.buf,
                            desc = 'Format on save',
                            callback = formatting_func
                        })
                    end
                end
            })

            vim.api.nvim_create_autocmd("BufWritePost", {
                pattern = "*.{c,cc,cpp,h,hh,hpp}",
                desc = 'Format on save',
                callback = function(args)
                    if (vim.fn.getenv("HOSTNAME") == "shahmeera-dev") then
                        local filename = vim.api.nvim_buf_get_name(args.buf)
                        local cmd = "/cb/tools/llvm/201910211756-206/bin/clang-format -i " ..
                            vim.fn.shellescape(filename)
                        os.execute(cmd)
                        vim.cmd("silent! edit!")
                    end
                end
            })
        end
    }
}
