return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
        require('nvim-treesitter').setup({
            install_dir = vim.fn.stdpath('data') .. '/site'
        })
    end
}
-- command to install lang 
--
-- :lua require('nvim-treesitter').install({'rust'}):wait(300000)
--                                           ^^^^^ Replace this with lang you want to install 
--
--                                           To check the installed parser  > ls ~/.local/share/nvim/site/parser/
