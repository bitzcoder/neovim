vim.cmd [[
try
  colorscheme tokyonight
  " colorscheme darkplus
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
