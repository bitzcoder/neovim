return {
  -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
  "jose-elias-alvarez/null-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    local async_formatting = function(bufnr)
      -- Check if the buffer number is provided, otherwise get the current buffer number
      bufnr = bufnr or vim.api.nvim_get_current_buf()
      -- Call lsp.buf_request for textDocument/formatting and apply the results
      vim.lsp.buf_request(bufnr, "textDocument/formatting", vim.lsp.util.make_formatting_params({}), function(err, res, ctx)
        if err then
          local err_msg = type(err) == "string" and err or err.message
          -- modify the log message / level (or ignore it completely)
          vim.notify("formatting: " .. err_msg, vim.log.levels.WARN)
          return
        end
        -- don't apply results if buffer is unloaded or has been modified
        if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, "modified") then
          return
        end
        if res then
          local client = vim.lsp.get_client_by_id(ctx.client_id)
          vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or "utf-16")
          vim.api.nvim_buf_call(bufnr, function()
            vim.cmd("silent noautocmd update")
          end)
        end
      end)
    end

    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    local formatting = null_ls.builtins.formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    local diagnostics = null_ls.builtins.diagnostics

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    null_ls.setup({
      debug = false,
      border = "rounded",
      sources = {
        formatting.prettier.with({ extra_args = { "--config", vim.fn.expand("~/.config/nvim/utils/prettierrc.toml") } }),
        formatting.black.with({ extra_args = { "--config", vim.fn.expand("~/.config/nvim/utils/black.toml") } }),
        formatting.stylua.with({ extra_args = { "--config-path", vim.fn.expand("~/.config/nvim/utils/stylua.toml") } }),
        diagnostics.pylint.with({ extra_args = { "--rcfile", vim.fn.expand("~/.config/nvim/utils/pylint.toml") } }),
      },
      -- Format on save
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              async_formatting(bufnr)
              -- Call lsp.buf.format with a filter function to format using null-ls client
              -- vim.lsp.buf.format({
              --   filter = function(client)
              --     return client.name == "null-ls"
              --   end,
              --   bufnr = bufnr,
              -- })
            end,
          })
        end
      end, --
    })
  end,
}
