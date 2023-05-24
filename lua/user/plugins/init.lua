return {
	"moll/vim-bbye",
	event = { "BufRead" },
	keys = { { "<leader>c", "<cmd>Bdelete!<cr>", desc = "Close Buffer" } },
}
