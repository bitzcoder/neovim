vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4

local map = vim.keymap.set

map("n", "<C-'>", function()
  vim.cmd.term("python3 '%'")
end, {
  silent = true,
  buffer = true,
})
