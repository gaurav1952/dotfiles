 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#000000',
    base01 = '#121319',
    base02 = '#1d1e23',
    base03 = '#8f909a',
    base04 = '#c5c6d0',
    base05 = '#e3e2e9',
    base06 = '#e3e2e9',
    base07 = '#e3e2e9',
    base08 = '#ffb4ab',
    base09 = '#e2bbdb',
    base0A = '#c1c5dd',
    base0B = '#b4c5ff',
    base0C = '#e2bbdb',
    base0D = '#b4c5ff',
    base0E = '#c1c5dd',
    base0F = '#93000a',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#e3e2e9',          bg = '#000000' })
  hi('TelescopeBorder',         { fg = '#8f909a',             bg = '#000000' })
  hi('TelescopePromptNormal',   { fg = '#e3e2e9',          bg = '#000000' })
  hi('TelescopePromptBorder',   { fg = '#8f909a',             bg = '#000000' })
  hi('TelescopePromptPrefix',   { fg = '#b4c5ff',             bg = '#000000' })
  hi('TelescopePromptCounter',  { fg = '#c5c6d0',  bg = '#000000' })
  hi('TelescopePromptTitle',    { fg = '#000000',             bg = '#b4c5ff' })
  hi('TelescopePreviewTitle',   { fg = '#000000',             bg = '#c1c5dd' })
  hi('TelescopeResultsTitle',   { fg = '#000000',             bg = '#e2bbdb' })
  hi('TelescopeSelection',      { fg = '#e3e2e9',          bg = '#1d1e23' })
  hi('TelescopeSelectionCaret', { fg = '#b4c5ff',             bg = '#1d1e23' })
  hi('TelescopeMatching',       { fg = '#b4c5ff',             bold = true })
end

 -- Register a signal handler for SIGUSR1 (matugen updates)
 local signal = vim.uv.new_signal()
 signal:start(
   'sigusr1',
   vim.schedule_wrap(function()
     package.loaded['matugen'] = nil
     require('matugen').setup()
   end)
 )

 return M
