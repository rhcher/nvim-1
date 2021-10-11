local tools = {}
local conf = require "modules.tools.config"

tools["Olical/conjure"] = {
  ft = { "scheme", "racket" },
}

tools["Olical/aniseed"] = {
  after = "conjure",
  ft = "fennel",
}

tools["mbbill/undotree"] = {
  cmd = "UndotreeToggle",
  config = function()
    vim.g.undotree_SetFocusWhenToggle = 1
  end,
}

tools["antoinemadec/FixCursorHold.nvim"] = {}

tools["tpope/vim-repeat"] = {
  event = "BufReadPre",
}

tools["kevinhwang91/nvim-bqf"] = {
  branch = "dev",
  config = conf.bqf,
}

tools["mhinz/vim-grepper"] = {
  cmd = { "Grepper", "<plug>(GrepperOperator)" },
  config = conf.vim_grepper,
}

tools["akinsho/nvim-toggleterm.lua"] = {
  event = "BufReadPre",
  config = conf.toggleterm,
}

tools["liuchengxu/vista.vim"] = {
  cmd = "Vista",
  config = conf.vim_vista,
}

tools["brooth/far.vim"] = {
  cmd = { "Farf", "Farp" },
  config = function()
    vim.g["far#source"] = "rg"
    vim.g["far#auto_preview"] = 0
    vim.g["far#auto_preview_on_start"] = 0
  end,
}

tools["iamcco/markdown-preview.nvim"] = {
  ft = "markdown",
  config = function()
    vim.g.mkdp_auto_start = 0
  end,
}

return tools
