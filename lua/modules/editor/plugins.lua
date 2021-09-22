local editor = {}
local conf = require "modules.editor.config"

editor["windwp/nvim-autopairs"] = {
  after = "nvim-cmp",
  config = conf.autopairs,
}

editor["andymass/vim-matchup"] = {
  event = "BufEnter",
  config = function ()
    vim.g.matchup_matchparen_deferred = 1
    vim.g.matchup_matchparen_hi_surround_always = 1
  end
}

editor["calebsmith/vim-lambdify"] = {
  event = "BufEnter",
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

editor["tpope/vim-surround"] = {
  event = { "BufReadPre", "BufNewFile" },
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
