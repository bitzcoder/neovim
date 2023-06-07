return {
  "akinsho/toggleterm.nvim",
  event = { "BufReadPost" },
  version = "*",
  config = function()
    local status_ok, toggleterm = pcall(require, "toggleterm")
    if not status_ok then
      return
    end

    toggleterm.setup({
      size = 20,
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "float",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    })

    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
      vim.keymap.set("t", "<C-[>", [[<C-\><C-n>]], opts)
      vim.keymap.set("t", "jj", [[<C-\><C-n>]], opts)
      vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
      vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
    end

    vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({
      cmd = "lazygit",
      hidden = true,
      direction = "float",
      float_opts = {
        border = "double",
        width = 100000,
        height = 100000,
      },
      on_open = function(_)
        vim.cmd("startinsert!")

        -- Make "Esc" and "j" keys work properly within lazygit
        local keymaps = vim.api.nvim_buf_get_keymap(0, "t")
        for _, keymap in ipairs(keymaps) do
          if keymap.lhs == "<Esc>" or keymap.lhs == "jj" then
            vim.keymap.del("t", keymap.lhs, { buffer = 0 })
          end
        end
      end,
    })

    function _LAZYGIT_TOGGLE()
      lazygit:toggle()
    end

    local node = Terminal:new({ cmd = "node", hidden = true })

    function _NODE_TOGGLE()
      node:toggle()
    end

    local ncdu = Terminal:new({ cmd = "ncdu", hidden = true })

    function _NCDU_TOGGLE()
      ncdu:toggle()
    end

    local htop = Terminal:new({ cmd = "htop", hidden = true })

    function _HTOP_TOGGLE()
      htop:toggle()
    end

    local python = Terminal:new({ cmd = "python", hidden = true })

    function _PYTHON_TOGGLE()
      python:toggle()
    end

    function _RUN_LANGUAGE()
      local filetype = vim.bo.filetype
      if filetype == "python" then
        vim.cmd("TermExec cmd='python %'")
      elseif filetype == "rust" then
        vim.cmd("TermExec cmd='cargo run'")
      elseif filetype == "c" then
        vim.cmd("TermExec cmd='gcc % -o out && ./out'")
      else
        print("No Execute cmd for language: " .. filetype)
      end
    end
  end,
}
