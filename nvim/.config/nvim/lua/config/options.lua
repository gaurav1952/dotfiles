-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

-- Indentation
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true      -- spaces instead of tabs
vim.opt.smartindent = true    -- auto indent on new line

-- Search
vim.opt.ignorecase = true     -- case insensitive search
vim.opt.smartcase = true      -- unless you type uppercase
vim.opt.hlsearch = true       -- highlight results
vim.opt.incsearch = true      -- highlight as you type

-- Appearance
vim.opt.termguicolors = true  -- full color support
vim.opt.signcolumn = "yes"    -- always show sign column (prevents shifting)
vim.opt.scrolloff = 8         -- keep 8 lines above/below cursor
vim.opt.sidescrolloff = 8     -- keep 8 columns left/right of cursor
vim.opt.wrap = false          -- no line wrapping

-- Behavior
vim.opt.mouse = "a"           -- enable mouse
vim.opt.clipboard = "unnamedplus"  -- use system clipboard
vim.opt.splitright = true     -- vertical splits go right
vim.opt.splitbelow = true     -- horizontal splits go below
vim.opt.swapfile = false      -- no swap files
vim.opt.backup = false        -- no backup files
vim.opt.undofile = true       -- persistent undo history

-- Performance
vim.opt.updatetime = 250      -- faster completion/diagnostics
vim.opt.timeoutlen = 300      -- faster keymap timeout
