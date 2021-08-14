local config = {}

function config.autopairs()
  local npairs = require "nvim-autopairs"
  local Rule = require "nvim-autopairs.rule"
  local cond = require "nvim-autopairs.conds"
  npairs.setup {
    enable_check_bracket_line = true,
    check_ts = true,
  }
  npairs.add_rules {
    -- Rule("'", "'")
    --   :with_pair(cond.not_before_regex_check "%w")
    --   :with_pair(cond.not_filetypes { "rkt", "scm", "lisp" }),
    Rule(" ", " ")
      :with_pair(function(opts)
        local pair = opts.line:sub(opts.col - 1, opts.col)
        return vim.tbl_contains({ "()", "{}", "[]" }, pair)
      end)
      :with_move(cond.none())
      :with_cr(cond.none())
      :with_del(function(opts)
        local col = vim.api.nvim_win_get_cursor(0)[2]
        local context = opts.line:sub(col - 1, col + 2)
        return vim.tbl_contains({ "(  )", "{  }", "[  ]" }, context)
      end),
    Rule("", " )")
      :with_pair(cond.none())
      :with_move(function(opts)
        return opts.char == ")"
      end)
      :with_cr(cond.none())
      :with_del(cond.none())
      :use_key ")",
    Rule("", " }")
      :with_pair(cond.none())
      :with_move(function(opts)
        return opts.char == "}"
      end)
      :with_cr(cond.none())
      :with_del(cond.none())
      :use_key "}",
    Rule("", " ]")
      :with_pair(cond.none())
      :with_move(function(opts)
        return opts.char == "]"
      end)
      :with_cr(cond.none())
      :with_del(cond.none())
      :use_key "]",
  }
  local parenthesis_rule = npairs.get_rule "("
  parenthesis_rule:with_pair(function()
    if vim.fn.pumvisible() then
      vim.cmd [[ call timer_start(0, { -> luaeval('require"compe"._close()')})]]
    end
    return true
  end)
  npairs.get_rule("'"):with_pair(cond.not_filetypes { "rkt", "scheme", "lisp" })
end

function config.nvim_colorizer()
  require("colorizer").setup {
    css = { rgb_fn = true },
    scss = { rgb_fn = true },
    sass = { rgb_fn = true },
    stylus = { rgb_fn = true },
    vim = { names = true },
    tmux = { names = false },
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    html = {
      mode = "foreground",
    },
  }
end

function config.vim_cursorwod()
  vim.api.nvim_command "augroup user_plugin_cursorword"
  vim.api.nvim_command "autocmd!"
  vim.api.nvim_command "autocmd FileType NvimTree,lspsagafinder,dashboard,vista let b:cursorword = 0"
  vim.api.nvim_command "autocmd WinEnter * if &diff || &pvw | let b:cursorword = 0 | endif"
  vim.api.nvim_command "autocmd InsertEnter * let b:cursorword = 0"
  vim.api.nvim_command "autocmd InsertLeave * let b:cursorword = 1"
  vim.api.nvim_command "augroup END"
end

return config
