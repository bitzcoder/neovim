local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup({
  ensure_installed = "",   -- one of "all" or a list of languages
  ignore_install = { "" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,         -- false will disable the whole extension
    disable = { "css" },   -- list of language that will be disabled
    -- additional_vim_regex_highlighting = true -- <= THIS LINE is the magic!
  },
  autopairs = {
    enable = true,
  },
  indent = { enable = true, disable = { "python", "css", "lua", "rust" } },
  -- indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "n",
      scope_incremental = "<tab>",
      node_decremental = "grm",
    },
  },
})
