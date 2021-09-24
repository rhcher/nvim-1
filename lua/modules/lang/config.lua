local config = {}

function config.nvim_treesitter()
  vim.api.nvim_command "set foldmethod=expr"
  vim.api.nvim_command "set foldexpr=nvim_treesitter#foldexpr()"
  require("nvim-treesitter.configs").setup {
    ensure_installed = { "c", "cpp", "rust", "lua", "python", "cmake", "haskell" },
    autopairs = { enable = true },
    highlight = {
      enable = true,
    },
    textobjects = {
      swap = {
        enable = true,
        swap_next = { ["<space>i"] = "@parameter.inner" },
        swap_previous = { ["<space>I"] = "@parameter.inner" },
      },
      select = {
        enable = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          -- ["ia"] = "@parameter.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@function.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
    },
  }
end

return config
