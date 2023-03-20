local status_ok, mason, masonconfig, lspconfig = pcall(function()
  return require("mason"), require("mason-lspconfig"), require("lspconfig")
end)
if not status_ok then
  return
end

require('lspconfig.ui.windows').default_options.border = 'rounded'

mason.setup({
  check_outdated_packages_on_open = true,
  ui = {
    icons = {
      package_installed = '',
      package_pending = '󰇚 ',
      package_uninstalled = '',
    },
    border = "rounded",
    width = 0.8,
    height = 0.8,
  }
})

-- Server Names = "https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md"
local servers = { "jsonls", "lua_ls", "pyright", "html", "rust_analyzer" }

masonconfig.setup({
  ensure_installed = servers,
})

for _, server in pairs(servers) do
  local opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }
  local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
  if has_custom_opts then
    opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
  end
  lspconfig[server].setup(opts)
end
