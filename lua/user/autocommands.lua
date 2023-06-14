local augroup = function(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "" },
  callback = function()
    local get_project_dir = function()
      local cwd = vim.fn.getcwd()
      local project_dir = vim.split(cwd, "/")
      local project_name = project_dir[#project_dir]
      return project_name
    end
    vim.opt.title = true
    vim.opt.titlestring = get_project_dir() .. " - nvim"
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("CloseWithQ"),
  pattern = {
    "OverseerForm",
    "OverseerList",
    "floggraph",
    "fugitive",
    "git",
    "help",
    "lspinfo",
    "man",
    "neotest-output",
    "neotest-summary",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "toggleterm",
    "tsplayground",
    "vim",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

-- fix comment
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  group = augroup("comment_newline"),
  pattern = { "*" },
  callback = function()
    vim.cmd([[set formatoptions-=cro]])
  end,
})

-- Toggle Between Absolute and Relative Line Numbers.
-- local numbertoggle = vim.api.nvim_create_augroup("NumberToggle", {})
-- vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" }, {
--   pattern = "*",
--   group = numbertoggle,
--   callback = function()
--     if vim.o.nu and vim.api.nvim_get_mode().mode ~= "i" then
--       vim.opt.relativenumber = true
--     end
--   end,
-- })
-- vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" }, {
--   pattern = "*",
--   group = numbertoggle,
--   callback = function()
--     if vim.o.nu then
--       vim.opt.relativenumber = false
--       vim.cmd("redraw")
--     end
--   end,
-- })

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

-- Auto close Nvim-Tree if it's the last buffer
vim.api.nvim_create_autocmd("QuitPre", {
  callback = function()
    local invalid_win = {}
    local wins = vim.api.nvim_list_wins()
    for _, w in ipairs(wins) do
      local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
      if bufname:match("NvimTree_") ~= nil then
        table.insert(invalid_win, w)
      end
    end
    if #invalid_win == #wins - 1 then
      -- Should quit, so we close all invalid windows.
      for _, w in ipairs(invalid_win) do
        vim.api.nvim_win_close(w, true)
      end
    end
  end,
})

-- Open help in a new buffer instead of a vsplit
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*",
  callback = function(event)
    if vim.bo[event.buf].filetype == "help" then
      vim.cmd.only()
      vim.bo.buflisted = true
    end
  end,
})
-- resize splits if window got resized
-- vim.api.nvim_create_autocmd({ "VimResized" }, {
--   group = augroup("resize_splits"),
--   callback = function()
--     vim.cmd("tabdo wincmd =")
--   end,
-- })

-- clear cmd output
vim.api.nvim_create_autocmd({ "CursorHoldI" }, {
  group = augroup("clear_term"),
  callback = function()
    vim.fn.timer_start(3000, function()
      vim.cmd.echon('""')
    end)
  end,
})

-- Go to last location when opening a buffer
vim.api.nvim_create_autocmd("BufReadPre", {
  pattern = "*",
  callback = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "<buffer>",
      once = true,
      callback = function()
        vim.cmd([[if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif]])
      end,
    })
  end,
})
