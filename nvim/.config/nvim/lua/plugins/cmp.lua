return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",   -- lsp completions
            "hrsh7th/cmp-buffer",      -- buffer word completions
            "hrsh7th/cmp-path",        -- file path completions
            "L3MON4D3/LuaSnip",        -- snippet engine
            "saadparwaiz1/cmp_luasnip" -- snippet completions
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-k>"] = cmp.mapping.select_prev_item(), -- prev suggestion
                    ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),     -- trigger completion
                    ["<C-e>"] = cmp.mapping.abort(),            -- close completion
                    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- confirm
                    ["<Tab>"] = cmp.mapping(function(fallback)  -- tab through suggestions
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" }, -- lsp
                    { name = "luasnip" },  -- snippets
                    { name = "buffer" },   -- buffer words
                    { name = "path" },     -- file paths
                }),
            })
        end
    }
}
