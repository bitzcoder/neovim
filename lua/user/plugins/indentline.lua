return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    char = "┊",
    context_char = "▏",
    show_end_of_line = false,
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = false,
    show_trailing_blankline_indent = false,
    show_first_indent_level = true,
    use_treesitter = true,
    -- use_treesitter_scope = true,
    filetype_exclude = {
      "norg",
      "help",
      "startify",
      "dashboard",
      "packer",
      "neogitstatus",
      "NvimTree",
      "Trouble",
      "alpha",
      "neo-tree",
    },
    buftype_exclude = {
      "terminal",
      "nofile",
    },
    context_patterns = {
      "class",
      "return",
      "function",
      "method",
      "^if",
      "^while",
      "jsx_element",
      "^for",
      "^object",
      "^table",
      "block",
      "arguments",
      "if_statement",
      "else_clause",
      "jsx_element",
      "jsx_self_closing_element",
      "try_statement",
      "catch_clause",
      "import_statement",
      "operation_type",
    },

    -- char_highlight_list = {
    --   "IndentBlanklineIndent1",
    --   "IndentBlanklineIndent2",
    --   "IndentBlanklineIndent3",
    --   "IndentBlanklineIndent4",
    --   "IndentBlanklineIndent5",
    --   "IndentBlanklineIndent6",
    -- },
  },
}
-- vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]
-- vim.opt.list = true
-- vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "space:"
-- vim.opt.listchars:append "eol:↴"
