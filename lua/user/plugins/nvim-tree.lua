return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local function on_attach(bufnr)
      local api = require('nvim-tree.api')

      local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      api.config.mappings.default_on_attach(bufnr) -- This line will add all the default mappings

      -- mark operation
      local mark_move_j = function()
        api.marks.toggle()
        vim.cmd("norm j")
      end
      local mark_move_k = function()
        api.marks.toggle()
        vim.cmd("norm k")
      end

      -- marked files operation
      local mark_trash = function()
        local marks = api.marks.list()
        if #marks == 0 then
          table.insert(marks, api.tree.get_node_under_cursor())
        end
        vim.ui.input({ prompt = string.format("Trash %s files? [y/n] ", #marks) }, function(input)
          if input == "y" then
            for _, node in ipairs(marks) do
              api.fs.trash(node)
            end
            api.marks.clear()
            api.tree.reload()
          end
        end)
      end

      local mark_remove = function()
        local marks = api.marks.list()
        if #marks == 0 then
          table.insert(marks, api.tree.get_node_under_cursor())
        end
        vim.ui.input({ prompt = string.format("Remove/Delete %s files? [y/n] ", #marks) }, function(input)
          if input == "y" then
            for _, node in ipairs(marks) do
              api.fs.remove(node)
            end
            api.marks.clear()
            api.tree.reload()
          end
        end)
      end

      local mark_copy = function()
        local marks = api.marks.list()
        if #marks == 0 then
          table.insert(marks, api.tree.get_node_under_cursor())
        end
        for _, node in pairs(marks) do
          api.fs.copy.node(node)
        end
        api.marks.clear()
        api.tree.reload()
      end

      local mark_cut = function()
        local marks = api.marks.list()
        if #marks == 0 then
          table.insert(marks, api.tree.get_node_under_cursor())
        end
        for _, node in pairs(marks) do
          api.fs.cut(node)
        end
        api.marks.clear()
        api.tree.reload()
      end

      -- Mappings removed via: remove_keymaps OR view.mappings.list..action = ""
      --
      -- The dummy set before del is done for safety, in case a default mapping does not exist.
      --
      -- You might tidy things by removing these along with their default mapping.
      vim.keymap.set('n', 'O', '', { buffer = bufnr })
      vim.keymap.del('n', 'O', { buffer = bufnr })
      vim.keymap.set('n', '<2-RightMouse>', '', { buffer = bufnr })
      vim.keymap.del('n', '<2-RightMouse>', { buffer = bufnr })
      vim.keymap.set('n', 'D', '', { buffer = bufnr })
      vim.keymap.del('n', 'D', { buffer = bufnr })
      vim.keymap.set('n', 'E', '', { buffer = bufnr })
      vim.keymap.del('n', 'E', { buffer = bufnr })


      -- Mappings migrated from view.mappings.list
      vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))
      vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
      vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
      vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
      vim.keymap.set("n", "J", mark_move_j, opts("Toggle Bookmark Down"))
      vim.keymap.set("n", "K", mark_move_k, opts("Toggle Bookmark Up"))
      vim.keymap.set("n", "dd", mark_cut, opts("Cut File(s)"))
      vim.keymap.set("n", "df", mark_trash, opts("Trash File(s)"))
      vim.keymap.set("n", "dF", mark_remove, opts("Remove File(s)"))
      vim.keymap.set("n", "yy", mark_copy, opts("Copy File(s)"))
      vim.keymap.set("n", "mv", api.marks.bulk.move, opts("Move Bookmarked"))

      -- You will need to insert "your code goes here" for any mappings with a custom action_cb
      vim.keymap.set('n', 'A', api.tree.expand_all, opts('Expand All'))
      vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
      vim.keymap.set('n', 'C', api.tree.change_root_to_node, opts('CD'))
      vim.keymap.set('n', 'P', function()
        local node = api.tree.get_node_under_cursor()
        print(node.absolute_path)
      end, opts('Print Node Path'))

      vim.keymap.set('n', 'Z', api.node.run.system, opts('Run System'))
    end

    require("nvim-tree").setup {

      on_attach = on_attach,
      update_focused_file = {
        enable = true,
        update_cwd = true,
        -- ignore_list = { "toggleterm", "lazygit", "term" },
      },
      renderer = {
        root_folder_modifier = ":t",
        icons = {
          glyphs = {
            default = "",
            symlink = "",
            folder = {
              arrow_open = "",
              arrow_closed = "",
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
            git = {
              unstaged = "",
              staged = "S",
              unmerged = "",
              renamed = "➜",
              untracked = "U",
              deleted = "",
              ignored = "◌",
            },
          },
        },
      },
      diagnostics = {
        enable = false,
        show_on_dirs = true,
        icons = {
          hint = "󰌵",
          info = "",
          warning = "",
          error = "",
        },
      },
      view = {
        width = 30,
        side = "left",
      },

    }
  end,
}
