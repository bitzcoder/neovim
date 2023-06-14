return {

  {
    "moll/vim-bbye",
    enabald = true,
    event = { "BufRead" },
    keys = { { "<leader>c", "<cmd>Bdelete!<cr>", desc = "Close Buffer" } },
  },

  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    opts = {
      window = {
        blend = 0, -- &winblend for the window
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      },
    },
  },
}
