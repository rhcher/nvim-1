local editor = {}
local conf = require "modules.editor.config"

editor["windwp/nvim-autopairs"] = {
  event = { "BufReadPre", "BufNewFile" },
  config = conf.autopairs,
}

editor["max397574/better-escape.nvim"] = {
  event = "BufEnter",
  config = function ()
    require("better_escape").setup({
      mapping = {"jj"},
      timeout = 300,
    })
  end
}

editor["guns/vim-sexp"] = {
  ft = { "racket", "scheme", "fennel", "lisp", "clojure" },
}

editor["tpope/vim-sexp-mappings-for-regular-people"] = {
  after = "vim-sexp",
}

editor["andymass/vim-matchup"] = {
  commit = "e5eefcc04eb1cf82fc396e89acaf1d680543f7d7",
  event = "BufEnter",
  config = conf.matchup,
}

editor["wellle/targets.vim"] = {
  config = function()
    vim.g.targets_seekRanges =
      "cc cr cb cB lc ac Ac lr lb ar ab rr rb bb ll al aa"
  end,
}

editor["calebsmith/vim-lambdify"] = {
  after = "vim-racket",
  ft = { "scheme", "lisp", "racket" },
}

editor["norcalli/nvim-colorizer.lua"] = {
  cmd = { "ColorizerToggle" },
  config = conf.nvim_colorizer,
}

editor["itchyny/vim-cursorword"] = {
  event = { "InsertEnter", "BufNewFile" },
  config = conf.vim_cursorwod,
}

editor["hrsh7th/vim-eft"] = {
  opt = true,
  config = function()
    vim.g.eft_ignorecase = true
  end,
}

editor["machakann/vim-sandwich"] = {
  -- keys = { "sr", "sa", "sd" }
}

editor["tpope/vim-sleuth"] = {
  event = "BufEnter",
  config = function()
    vim.g.sleuth_automatic = 1
  end,
}

editor["tpope/vim-commentary"] = {
  event = { "BufReadPre", "BufNewFile" },
}

-- editor["kana/vim-niceblock"] = {
--   opt = true,
-- }

editor["lewis6991/impatient.nvim"] = {}

return editor
