local map = vim.keymap.set

vim.g.mapleader = " " 
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)


-- Copy Pasting
map("n", "<leader>p", "\"+p", { desc = "Clipboard Pasting"})
map("v", "<leader>y", "\"+y", { desc = "Clipboard Yanking"})

-- Moving cursor to start and end of line
map("n", "<leader>f", "^", { desc = "Move cursor to start of the line"})
map("n", "<leader>g", "g_", { desc = "Move cursor to end of the line"})

-- Better escape
map("i", "jj", "<Esc>", { desc = "Escape insert mode" })

-- Save & quit
map("n", "<leader>w", ":w<CR>", { desc = "Save file" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })
map("n", "<leader>Q", ":qa!<CR>", { desc = "Force quit all" })

-- Split windows
map("n", "<leader>sv", ":vsplit<CR>", { desc = "Split vertical" })
map("n", "<leader>sh", ":split<CR>",  { desc = "Split horizontal" })
map("n", "<leader>se", "<C-w>=",      { desc = "Make splits equal size" })
map("n", "<leader>sx", ":close<CR>",  { desc = "Close split" })


-- Move between windows
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })

-- Resize windows
map("n", "<C-Up>",    ":resize +2<CR>",          { desc = "Increase window height" })
map("n", "<C-Down>",  ":resize -2<CR>",          { desc = "Decrease window height" })
map("n", "<C-Left>",  ":vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Better indenting (stay in visual mode)
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Move lines up/down in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Better up/down on wrapped lines
map("n", "j", "gj", { desc = "Move down (wrapped)" })
map("n", "k", "gk", { desc = "Move up (wrapped)" })

-- Keep cursor centered when scrolling
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })

-- Keep cursor centered when searching
map("n", "n", "nzzzv", { desc = "Next search result" })
map("n", "N", "Nzzzv", { desc = "Prev search result" })

-- Clear search highlight
map("n", "<Esc>", ":nohl<CR>", { desc = "Clear search highlight" })

-- Paste without losing register
map("v", "p", '"_dP', { desc = "Paste without yanking" })

-- Delete without yanking
map({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yank" })

-- Select all
map("n", "<leader>e", "gg<S-v>G", { desc = "Select all" })

-- Buffer navigation
map("n", "<Tab>",   ":bnext<CR>",     { desc = "Next buffer" })
map("n", "<S-Tab>", ":bprevious<CR>", { desc = "Prev buffer" })
map("n", "<leader>x", ":bdelete<CR>", { desc = "Close buffer" })
