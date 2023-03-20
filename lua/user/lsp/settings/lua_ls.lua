return {
	-- on_attach = function(client)
	--   client.server_capabilities.documentFormattingProvider = false
	--   client.server_capabilities.documentRangeFormattingProvider = false
	-- end,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
}
