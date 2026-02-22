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
                ensure_installed = { "pyright", "lua_ls", "gopls" }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()

            -- Python
            vim.lsp.config("pyright", {})
            vim.lsp.enable("pyright")

            -- Lua
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" }
                        }
                    }
                }
            })
            vim.lsp.enable("lua_ls")

            -- Go
            vim.lsp.config("gopls", {})
            vim.lsp.enable("gopls")

            -- Keymaps
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(e)
                    local map = vim.keymap.set
                    local opts = { buffer = e.buf }

                    map("n", "gd", vim.lsp.buf.definition, opts)          -- go to definition
                    map("n", "gr", vim.lsp.buf.references, opts)           -- find references
                    map("n", "K", vim.lsp.buf.hover, opts)                 -- hover docs
                    map("n", "<leader>rn", vim.lsp.buf.rename, opts)       -- rename symbol
                    map("n", "<leader>ca", vim.lsp.buf.code_action, opts)  -- code actions
                    map("n", "<leader>se", vim.diagnostic.open_float, opts) -- show error
                    map("n", "[d", vim.diagnostic.goto_prev, opts)         -- prev error
                    map("n", "]d", vim.diagnostic.goto_next, opts)         -- next error
                end
            })
        end
    }
}
