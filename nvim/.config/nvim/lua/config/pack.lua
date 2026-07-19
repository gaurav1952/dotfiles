vim.pack.add({
	{src= "https://github.com/rose-pine/neovim",name = "rose-pine",},
  -- {src= "https://github.com/catppuccin/nvim", name = "catppuccin" },
  {src= "https://github.com/saghen/blink.lib", name = "blink.lib"},
  {src= "https://github.com/saghen/blink.cmp"},
  {src= "https://github.com/nvim-lualine/lualine.nvim"},
  {src= "https://github.com/neovim/nvim-lspconfig"},
  {src = "https://github.com/stevearc/oil.nvim"},
  {src= "https://github.com/mason-org/mason.nvim"},
  {src= "https://github.com/mason-org/mason-lspconfig.nvim"},
  {src= "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim"},
  {src= "https://github.com/nvim-lua/plenary.nvim"},
  -- {src= "https://github.com/nvim-telescope/telescope.nvim"},
  {src= "https://github.com/ibhagwan/fzf-lua"},
  {src= "https://github.com/nvim-treesitter/nvim-treesitter"},
  {src= "https://github.com/folke/which-key.nvim" },
  {src= "https://github.com/windwp/nvim-autopairs" },
  {src= "https://github.com/akinsho/bufferline.nvim"},
  -- {src= "https://github.com/nvim-mini/mini.nvim"},
})

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
       ensure_installed = { "lua_ls", "pyright", "ts_ls" }
})

require("fzf-lua").setup({

})
-- require("telescope").setup({
--   defaults = {
--     file_ignore_patterns = { '.git/', 'node_modules/' }
--   },
-- })

-- local ts = require('nvim-treesitter')
-- ts.install({ 'lua', 'typescript', 'javascript', 'python', 'rust', 'bash', 'vim', 'vimdoc' })
--
-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = { 'lua', 'typescript', 'javascript', 'python', 'rust', 'bash' },
--   callback = function()
--     vim.treesitter.start()
--     vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
--   end,
-- })

require('blink.cmp').setup({
 keymap = {
    preset = 'none',
    ['<Tab>'] = { 'select_next', 'fallback' },
    ['<S-Tab>'] = { 'select_prev', 'fallback' },
    ['<CR>'] = { 'accept', 'fallback' },

    ['<C-space>'] = { 'show', 'hide' },
    ['<C-e>'] = { 'hide', 'fallback' },
  },

  appearance = {
    nerd_font_variant = 'normal'
  },

  signature = { enabled = true },

  completion = {
    menu={
      border="rounded",
      winblend = 10,

      draw = {
        treesitter = { "lsp" },
         columns = {
          { "kind_icon" },
          { "label", "label_description", gap = 1 },
          { "kind" },
        },
      },
     },

    documentation = {
      auto_show = true,
      window={
        border= "rounded",
      },
    }
  },

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },

  fuzzy = {
    implementation = "prefer_rust_with_warning"
  }
})
--------------------
---theme
--------------------
-- require("catppuccin").setup()
-- vim.cmd.colorscheme "catppuccin-nvim"

require("rose-pine").setup({
  variant = 'main',
  dark_variant = 'main',
  styles = {
     transparency = true,
  },
})
vim.cmd("colorscheme rose-pine")

require("lualine").setup({})

require("oil").setup({
  default_file_explorer = true,
  view_options = {
    show_hidden = true
  },
})


require("which-key").setup({
  preset = 'helix',
})

require("nvim-autopairs").setup({})
require("bufferline").setup({})



