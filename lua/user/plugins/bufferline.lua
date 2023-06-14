return {
  "akinsho/bufferline.nvim",
  event = { "BufReadPost" },
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      mode = "buffers", -- set to "tabs" to only show tabpages instead
      themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
      numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
      close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
      right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
      left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
      middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
      -- indicator = { style = "icon", icon = "▎" },
      buffer_close_icon = "󰅖",
      modified_icon = "●",
      close_icon = "",
      left_trunc_marker = "",
      right_trunc_marker = "",
      show_buffer_icons = true,
      show_buffer_close_icons = true,
      show_close_icon = true,
      show_tab_indicators = true,
      persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
      separator_style = "slant", -- "slant" | "slope" | "thick" | "thin" | { 'any', 'any' },
      enforce_regular_tabs = true,
      always_show_bufferline = true,
      color_icons = true,
      max_name_length = 30,
      max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
      truncate_names = true, -- whether or not tab names should be truncated
      diagnostics = "nvim_lsp", -- | "nvim_lsp" | "coc",
      diagnostics_update_in_insert = false,
      diagnostics_indicator = function(count)
        return "(" .. count .. ")"
      end,
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          highlight = "PanelHeading",
          padding = 1,
        },
      },
    },
    highlights = {
      fill = {
        fg = { attribute = "fg", highlight = "TabLine" },
        bg = { attribute = "bg", highlight = "TabLineFill" },
      },
      background = {
        fg = { attribute = "fg", highlight = "TabLine" },
        bg = { attribute = "bg", highlight = "TabLine" },
        italic = true,
      },
      buffer_visible = {
        fg = { attribute = "fg", highlight = "PmenuSel" },
        bg = { attribute = "bg", highlight = "TabLine" },
      },
      close_button = {
        fg = { attribute = "fg", highlight = "TabLine" },
        bg = { attribute = "bg", highlight = "TabLine" },
      },
      close_button_visible = {
        fg = { attribute = "fg", highlight = "TabLine" },
        bg = { attribute = "bg", highlight = "TabLine" },
      },
      modified = {
        fg = { attribute = "fg", highlight = "WarningMsg" },
        bg = { attribute = "bg", highlight = "TabLine" },
      },
      modified_selected = {
        fg = { attribute = "fg", highlight = "WarningMsg" },
        bg = { attribute = "bg", highlight = "Normal" },
      },
      modified_visible = {
        fg = { attribute = "fg", highlight = "WarningMsg" },
        bg = { attribute = "bg", highlight = "TabLine" },
      },
      separator = {
        fg = { attribute = "bg", highlight = "PmenuSel" },
        bg = { attribute = "bg", highlight = "TabLine" },
      },
      separator_selected = {
        fg = { attribute = "bg", highlight = "PmenuSel" },
        bg = { attribute = "bg", highlight = "Normal" },
      },
      separator_visible = {
        fg = { attribute = "bg", highlight = "PmenuSel" },
        bg = { attribute = "bg", highlight = "TabLine" },
      },
    },
  },
}
