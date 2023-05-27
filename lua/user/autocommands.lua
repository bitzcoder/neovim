-- Enable spellcheck on gitcommit and markdown
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Strip trailing spaces before write
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  callback = function()
    vim.cmd([[ %s/\s\+$//e ]])
  end,
})
vim.cmd([[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200})
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
  augroup end

  " Toggle Between Absolute and Relative Line Numbers.
  augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,CmdlineLeave,WinEnter * if &nu && mode() != 'i' | set rnu | endif
    autocmd BufLeave,FocusLost,InsertEnter,CmdlineEnter,WinLeave * if &nu | set nornu | redraw | endif
  augroup END

  " Can't remember what these do!!
  set ssop-=options
  set ssop-=folds
  let &t_Cs = "\e[4:3m"

  " Clears the cmdline messages when scrolling(off the window)
  " This is temporary fix (should work by default, doesn't for some reason.)
  autocmd WinScrolled * :echo

  " Closes Nvim-Tree while quiting neovim
  autocmd QuitPre * :NvimTreeClose

  " augroup _git
  "   autocmd!
  "   autocmd FileType gitcommit setlocal wrap
  "   autocmd FileType gitcommit setlocal spell
  " augroup end

 " INDENTATION
  au BufNewFile,BufRead *.py
    \ set expandtab       |" replace tabs with spaces
    \ set autoindent      |" copy indent when starting a new line
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
  augroup end

  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd =
  augroup end

  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end

  " " Open folds
  " autocmd BufEnter * normal zR

  " " This doesn't work with async = true
  " augroup AutoFormat
  "   autocmd!
  "   autocmd BufWritePre * lua vim.lsp.buf.format({async=true})
  "   autocmd BufWritePre * write
  " augroup END


  " autocmd insertenter,insertleave * set cul!
]])
