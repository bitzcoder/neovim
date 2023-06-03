local servers = { "jsonls", "lua_ls", "pyright", "html", "rust_analyzer" }

return {
  {
    -- Bridges Mason with LSP configuration
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = servers, -- Ensure specified servers are installed
      automatic_installation = true,
    },
    dependencies = {
      "williamboman/mason.nvim",
      build = ":MasonUpdate",
      opts = {
        check_outdated_packages_on_open = true,
        ui = {
          icons = {
            package_installed = "",
            package_pending = "󰇚 ",
            package_uninstalled = "",
          },
          border = "rounded",
          width = 0.8,
          height = 0.8,
        },
      },
    },
  },
  {
    -- Configuration for Neovim LSP
    "neovim/nvim-lspconfig",
    config = function()
      local status_lspconfig, lspconfig = pcall(require, "lspconfig")

      if not status_lspconfig then
        return
      end

      -- Configure border type for the LSP UI
      require("lspconfig.ui.windows").default_options.border = "rounded"

      -- Configuration for vim diagnostics and LSP handlers
      require("user.lsp.handlers").setup()

      -- Loop through each server and configure it with lspconfig
      for _, server in ipairs(servers) do
        -- Define the options for the server
        local opts = {
          on_attach = require("user.lsp.handlers").on_attach,
          capabilities = require("user.lsp.handlers").capabilities,
        }

        -- Try to load any custom options for the server from user.lsp.settings.{server}
        local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)

        -- Merge the custom options into the default options if they exist
        if has_custom_opts and type(server_custom_opts) == "table" then
          opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
        end

        -- Configure the server with lspconfig
        lspconfig[server].setup(opts)
      end
    end,
  },
}
