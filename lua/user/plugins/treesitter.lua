return {

  {
    "nvim-treesitter/nvim-treesitter-context", -- Keep e.g. function at top when scrolling below
    enabled = false,
    name = "treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    name = "ts_context_commentstring",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = "nvim-treesitter/nvim-treesitter",
  },
  {
    "mrjones2014/nvim-ts-rainbow", -- Rainbow parentheses
    -- enabled = false,
    event = { "BufReadPost", "BufNewFile" },
    dependencies = "nvim-treesitter/nvim-treesitter",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = "windwp/nvim-ts-autotag",
    build = function()
      local ts_update = require("nvim-treesitter.install").update({
        with_sync = true,
      })
      ts_update()
    end,
    config = function()
      require("nvim-treesitter.configs").setup({
        -- A list of parser names, or "all"
        ensure_installed = {
          "lua",
          "markdown",
          "python",
          "rust",
        },
        sync_install = false,
        -- auto_install = true,
        -- ignore_install = {  },

        highlight = {
          -- `false` will disable the whole extension
          enable = true,
          -- disable = { },
          additional_vim_regex_highlighting = false,
        },

        rainbow = {
          enable = true,
          extended_mode = true,
        },

        autotag = {
          enable = true, -- Through auto-tag plugin
        },

        indent = { -- Indentation based on = operator (experimental)
          enable = true,
        },

        context_commentstring = { -- For nvim-ts-context-commentstring plugin
          enable = true,
          enable_autocmd = false, -- Disabled when used with Comment.nvim
        },

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "n",
            scope_incremental = "<tab>",
            node_decremental = "grm",
          },
        },
        -- swap = {
        --   enable = true,
        --   swap_next = {
        --     ["<leader>xp"] = { query = "@parameter.inner", desc = "Swap parameter with the next one" },
        --   },
        --   swap_previous = {
        --     ["<leader>xP"] = { query = "@parameter.inner", desc = "Swap parameter with the previous one" },
        --   },
        -- },
      })

      -- Must installed zig via scoop in Windows
      -- if _G.IS_WINDOWS then
      --   require("nvim-treesitter.install").compilers = { "zig" }
      -- else
      --   require("nvim-treesitter.install").compilers = { "clang", "gcc", "cc", "cl", "zig" }
      -- end
    end,
  },
}
