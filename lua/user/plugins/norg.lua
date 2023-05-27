return {
  "nvim-neorg/neorg",
  ft = "norg",
  cmd = { "Neorg" },
  dependencies = { { "nvim-lua/plenary.nvim" }, { "nvim-treesitter/nvim-treesitter" } },
  build = ":Neorg sync-parsers",
  config = function()
    vim.opt.conceallevel = 2
    require("neorg").setup({
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {
          config = {
            folds = false,
          },
        },
        ["core.dirman"] = { -- Manage your directories with Neorg
          config = {
            workspaces = {
              notes = "~/Dropbox/Notes",
            },
            default_workspace = "notes",
            -- autodetect = true,
            -- autochdir = true,
          },
        },
        ["core.completion"] = {
          config = {
            engine = "nvim-cmp",
          },
        },
      },
    })
  end,
}
