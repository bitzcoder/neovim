return {
  "moll/vim-bbye",
  enabald = true,
  event = { "BufRead" },
  keys = { { "<leader>c", "<cmd>Bdelete!<cr>", desc = "Close Buffer" } },
}
