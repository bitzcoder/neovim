local options = {
	backup = false, -- creates a backup file
	clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	cmdheight = 2, -- more space in the neovim command line for displaying messages
	completeopt = { "menuone", "noselect" }, -- mostly just for cmp
	conceallevel = 0, -- so that `` is visible in markdown files
	fileencoding = "utf-8", -- the encoding written to a file
	hlsearch = true, -- highlight all matches on previous search pattern
	ignorecase = true, -- ignore case in search patterns
	mouse = "a", -- allow the mouse to be used in neovim
	pumheight = 10, -- pop up menu height
	showmode = false, -- we don't need to see things like -- INSERT -- anymore
	showtabline = 2, -- always show tabs
	smartcase = true, -- smart case
	smartindent = true, -- make indenting smarter again
	splitbelow = true, -- force all horizontal splits to go below current window
	splitright = true, -- force all vertical splits to go to the right of current window
	swapfile = false, -- creates a swapfile
	termguicolors = true, -- set term gui colors (most terminals support this)
	timeout = true,
	timeoutlen = 500, -- time to wait for a mapped sequence to complete (in milliseconds)
	undofile = true, -- enable persistent undo
	updatetime = 300, -- faster completion (4000ms default)
	writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
	expandtab = true, -- convert tabs to spaces
	shiftwidth = 2, -- the number of spaces inserted for each indentation
	tabstop = 2, -- insert 2 spaces for a tab
	cursorline = true, -- highlight the current line
	number = true, -- set numbered lines
	relativenumber = true, -- set relative numbered lines
	numberwidth = 2, -- set number column width to 2 {default 4}
	signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
	wrap = false, -- display lines as one long line
	linebreak = true, -- companion to wrap, don't split words
	scrolloff = 8, -- is one of my fav
	sidescrolloff = 8,
	-- laststatus = 3, -- Use global Statusline
	whichwrap = "bs<>[]hl", -- which "horizontal" keys are allowed to travel to prev/next line
	shell = "fish",
	spell = true,
	foldlevelstart = 99, -- Set the initial fold level
	fillchars = { -- Customize fold-related characters
		fold = " ",
	},
	foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').]]
		.. [[' ... '.trim(getline(v:foldend)).]]
		.. [[' ('.(v:foldend-v:foldstart).' lines folded...)']],
	-- title = true,
	-- titlestring = "%<%t %{&modified ? '*' : ''}%( (%{expand(\"%:~:.:h\")})%)%( %a%) - nvim",
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.g.python3_host_prog = "/home/asif/.venv/bin/python3"
vim.g.python_host_prog = "/home/asif/.venv/bin/python"

if vim.g.neovide then
	vim.g.neovide_remember_window_size = true
	vim.o.guifont = "monospace:h10" -- text below applies for VimScript
	vim.g.neovide_scale_factor = 1.0
	vim.g.neovide_transparency = 0.4
end

-- This can do what nvim impatient used to do!
vim.loader.enable()

-- vim.opt.shortmess = "ilmnrx"                        -- flags to shorten vim messages, see :help 'shortmess'
vim.opt.shortmess:append("c") -- don't give |ins-completion-menu| messages
vim.opt.iskeyword:append("-") -- hyphenated words recognized by searches
vim.opt.formatoptions:remove({ "c", "r", "o" }) -- don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles") -- separate vim plugins from neovim in case vim still in use
