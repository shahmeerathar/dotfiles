IS_CB = (vim.fn.getenv("HOSTNAME") == "shahmeera-dev") or (vim.fn.getenv("HOSTNAME") == "sc-r1rb5-ioasic16")

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
            if (IS_CB) then
                require("mason-lspconfig").setup({
                    ensure_installed = { "lua_ls", "ruff", "ty" }
                })
            else
                require("mason-lspconfig").setup({
                    ensure_installed = { "lua_ls", "ruff", "ty", "clangd", "rust_analyzer" }
                })
            end
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Configure lua_ls
            vim.lsp.config('lua_ls', {
                cmd = { 'lua-language-server' },
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

            -- Configure clangd
            vim.lsp.config('clangd', {
                cmd = {
                    "clangd",
                    "--header-insertion=never",
                    "--fallback-style=webkit"
                },
                capabilities = capabilities,
            })

            -- Configure ruff
            vim.lsp.config('ruff', {
                cmd = { 'ruff', 'server' },
                capabilities = capabilities,
            })

            -- Configure ty
            vim.lsp.config('ty', {
                cmd = { 'ty', 'server' },
                capabilities = capabilities,
            })

            if (not IS_CB) then
                -- Configure rust_analyzer
                vim.lsp.config('rust_analyzer', {
                    cmd = { 'rust-analyzer' },
                    capabilities = capabilities,
                })
            end

            -- Enable all configured LSP servers
            vim.lsp.enable('lua_ls')
            vim.lsp.enable('ruff')
            vim.lsp.enable('ty')
            vim.lsp.enable('clangd')
            if (not IS_CB) then
                vim.lsp.enable('rust_analyzer')
            end

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

                    if (not ((lsp_name == 'ruff' or lsp_name == 'clangd') and IS_CB)) then
                        vim.api.nvim_create_autocmd('BufWritePre', {
                            buffer = event.buf,
                            desc = 'Format on save',
                            callback = formatting_func
                        })
                    end
                end
            })

            if (IS_CB) then
                vim.api.nvim_create_autocmd("BufWritePost", {
                    pattern = "*.{c,cc,cpp,h,hh,hpp}",
                    desc = 'Format on save',
                    callback = function(args)
                        local filename = vim.api.nvim_buf_get_name(args.buf)
                        local cmd = "/cb/tools/llvm/201910211756-206/bin/clang-format -i " ..
                            vim.fn.shellescape(filename)
                        os.execute(cmd)
                        vim.cmd("silent! edit!")
                    end
                })
            end
        end
    }
}
