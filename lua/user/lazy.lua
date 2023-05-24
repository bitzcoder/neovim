local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Plugin Setup
require("lazy").setup("user.plugins", {
	ui = {
		border = "rounded",
	},
	debug = false,
	defaults = { lazy = false },
	checker = {
		enabled = false, -- automatically check for plugin updates
		concurrency = nil, ---@type number? Set to 1 to check for updates very slowly
		notify = true, -- get a notification when new updates are found
		frequency = 3600, -- check for updates every hour
	},
	change_detection = {
		enabled = true, -- automatically check for config file changes and reload the ui
		notify = false, -- get a notification when changes are found
	},
	install = {
		missing = true,
		colorscheme = { "tokyonight", "habamax" },
	},
	performance = {
		rtp = {
			disabled_plugins = {
				-- "gzip",
				-- "matchit",
				-- "matchparen",
				"netrwPlugin",
				-- "tarPlugin",
				-- "tohtml",
				-- "tutor",
				-- "zipPlugin",
				"netrw",
			},
		},
	},
})
