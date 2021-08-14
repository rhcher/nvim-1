local completion = {}
local conf = require "modules.completion.config"

completion["neovim/nvim-lspconfig"] = {
  event = "BufReadPre",
  config = conf.nvim_lsp,
}

completion["jasonrhansen/lspsaga.nvim"] = {
  branch = "finder-preview-fixes",
  cmd = "Lspsaga",
}

completion["hrsh7th/nvim-cmp"] = {
  config = conf.nvim_cmp,
  requires = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-calc",
    "hrsh7th/cmp-vsnip",
    "hrsh7th/cmp-path",
  },
}

completion["ray-x/lsp_signature.nvim"] = {
  event = "BufReadPost",
}

completion["hrsh7th/vim-vsnip"] = {
  event = "InsertCharPre",
  config = conf.vim_vsnip,
}

completion["ckipp01/stylua-nvim"] = {
  ft = "lua",
}

completion["nvim-telescope/telescope.nvim"] = {
  cmd = "Telescope",
  config = conf.telescope,
  requires = {
    { "nvim-lua/popup.nvim", opt = true },
    { "nvim-lua/plenary.nvim", opt = true },
    { "nvim-telescope/telescope-fzy-native.nvim", opt = true },
  },
}

completion["glepnir/smartinput.nvim"] = {
  ft = "go",
  config = conf.smart_input,
}

completion["mattn/vim-sonictemplate"] = {
  cmd = "Template",
  ft = { "go", "typescript", "lua", "javascript", "vim", "rust", "markdown" },
  config = conf.vim_sonictemplate,
}

completion["mattn/emmet-vim"] = {
  event = "InsertEnter",
  ft = {
    "html",
    "css",
    "javascript",
    "javascriptreact",
    "vue",
    "typescript",
    "typescriptreact",
  },
  config = conf.emmet,
}

return completion
