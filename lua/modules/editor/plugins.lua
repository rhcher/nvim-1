local editor = {}
local conf = require "modules.editor.config"

-- editor['Raimondi/delimitMate'] = {
--   event = 'InsertEnter',
--   config = conf.delimimate,
-- }
editor["windwp/nvim-autopairs"] = {
  event = "InsertEnter",
  config = conf.autopairs,
}

editor["rhysd/accelerated-jk"] = {
  opt = true,
}

editor["norcalli/nvim-colorizer.lua"] = {
  ft = { "html", "css", "sass", "vim", "typescript", "typescriptreact" },
  config = conf.nvim_colorizer,
}

editor["itchyny/vim-cursorword"] = {
  event = { "BufReadPre", "BufNewFile" },
  config = conf.vim_cursorwod,
}

editor["hrsh7th/vim-eft"] = {
  opt = true,
  config = function()
    vim.g.eft_ignorecase = true
  end,
}

editor["tpope/vim-surround"] = {
  event = "BufEnter",
}

editor["tpope/vim-sleuth"] = {
  event = "BufEnter",
  config = function()
    vim.g.sleuth_automatic = 0
  end,
}

editor["tpope/vim-commentary"] = {
  event = "InsertEnter",
}

editor["kana/vim-niceblock"] = {
  opt = true,
}

return editor
