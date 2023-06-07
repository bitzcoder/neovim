local opts = { remap = false, silent = true }
-- Shorten function name
local map = vim.keymap.set

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
--------------------------------------------------------- Normal ------------------------------------------------
-- Change the keybinding for incrementing numbers
map("n", "<C-i>", "<C-a>", opts)
-- Select all texts
map("n", "<C-a>", "ggVG", opts)

-- Better window navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Go the different buffers(requires bufferline plugin)
map("n", "<leader>1", ":BufferLineGoToBuffer 1<CR>", opts)
map("n", "<leader>2", ":BufferLineGoToBuffer 2<CR>", opts)
map("n", "<leader>3", ":BufferLineGoToBuffer 3<CR>", opts)
map("n", "<leader>4", ":BufferLineGoToBuffer 4<CR>", opts)
map("n", "<leader>5", ":BufferLineGoToBuffer 5<CR>", opts)
map("n", "<leader>6", ":BufferLineGoToBuffer 6<CR>", opts)
map("n", "<leader>7", ":BufferLineGoToBuffer 7<CR>", opts)
map("n", "<leader>8", ":BufferLineGoToBuffer 8<CR>", opts)
map("n", "<leader>9", ":BufferLineGoToBuffer 9<CR>", opts)
map("n", "<leader>0", ":BufferLineGoToBuffer -1<CR>", opts) -- Go to last buffer

-- Resize with arrows
map("n", "<C-Up>", ":resize -2<CR>", opts)
map("n", "<C-Down>", ":resize +2<CR>", opts)
map("n", "<C-Left>", ":vertical resize -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers(requires bufferline plugin)
map("n", "<tab>", ":BufferLineCycleNext<CR>", opts)
map("n", "<S-tab>", ":BufferLineCyclePrev<CR>", opts)

-- Move text up and down
map("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
map("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Move to the Beginning and end of the line
map({ "n", "v", "x", "o" }, "H", "^", opts)
map({ "n", "v", "x", "o" }, "L", "$", opts)

-- Center Cursors
map("n", "J", "mzJ`z", opts)
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

-- Deleting and Yanking without new line char
map("n", "dil", "dd:let @+=matchlist(strtrans(@+),'[ ]*\\zs.*\\ze\\^@')[0]<CR>", opts)
map("n", "yil", "yy:let @+=matchlist(strtrans(@+),'[ ]*\\zs.*\\ze\\^@')[0]<CR>", opts)

-- Search and Replace
map("n", "<A-r>", [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]], opts)

-- Setting "gx" manually for when netrw is disabled(Linux only)
map("n", "gx", "<cmd>!xdg-open <cfile><CR>", opts)

-- open terminal
map("n", "<leader>tt", ":term<cr>", opts)
-------------------------------------------------Insert --------------------------------------------------------

-- Press jj fast to enter Insert mode
map("i", "jj", "<ESC>", opts)

-- Break undo sequence
map("i", ".", ".<c-g>u", opts)
map("i", ";", ";<c-g>u", opts)
map("i", ",", ",<c-g>u", opts)
map("i", "(", "(<c-g>u", opts)
map("i", "{", "{<c-g>u", opts)
map("i", "[", "[<c-g>u", opts)

------------------------------------------------- Visual --------------------------------------------------------
-- Stay in indent mode
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Move text up and down
map("v", "<A-j>", ":m .+1<CR>==", opts)
map("v", "<A-k>", ":m .-2<CR>==", opts)

-- Paste without Yanking in Visual mode
map("v", "p", '"_dP', opts)

-------------------------------------------------- Visual Block -----------------------------------------------------
-- Move text up and down
map("x", "J", ":move '>+1<CR>gv-gv", opts)
map("x", "K", ":move '<-2<CR>gv-gv", opts)
map("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
map("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
