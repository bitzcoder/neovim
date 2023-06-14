return {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          enabled = false,
        },
        pyflakes = {
          enabled = false,
        },
        -- pylint = {
        --   enabled = true,
        --   args = { "--rcfile=~/.config/nvim/utils/pylint.toml" },
        -- },
        jedi_completion = {
          include_class_objects = true,
          include_function_objects = true,
          cache_for = {},
        },
      },
    },
  },
}
