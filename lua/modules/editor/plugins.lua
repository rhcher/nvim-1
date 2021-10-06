local editor = {}
local conf = require "modules.editor.config"

editor["windwp/nvim-autopairs"] = {
  event = { "BufReadPre", "BufNewFile" },
  config = conf.autopairs,
}

editor["andymass/vim-matchup"] = {
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
  ft = { "scheme", "lisp", "rkt" },
  event = "BufReadPre",
}

editor["norcalli/nvim-colorizer.lua"] = {
  ft = { "html", "css", "sass", "vim", "typescript", "typescriptreact" },
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

editor["kana/vim-niceblock"] = {
  opt = true,
}

editor["lewis6991/impatient.nvim"] = {}

return editor
