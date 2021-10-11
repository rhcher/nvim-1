local ui = {}
local conf = require "modules.ui.config"

ui["srcery-colors/srcery-vim"] = {
  after = "lualine.nvim",
  config = function ()
    vim.g.srcery_italic = 1
    vim.cmd [[colorscheme srcery]]
  end
}

-- ui["glepnir/dashboard-nvim"] = {
--   config = conf.dashboard,
-- }

ui["hoob3rt/lualine.nvim"] = {
  config = conf.lualine,
  requires = { "kyazdani42/nvim-web-devicons", opt = true },
}

-- ui["nvim-lua/lsp-status.nvim"] = {}

ui["akinsho/bufferline.nvim"] = {
  config = conf.nvim_bufferline,
  requires = "kyazdani42/nvim-web-devicons",
}

ui["kyazdani42/nvim-tree.lua"] = {
  cmd = { "NvimTreeToggle", "NvimTreeOpen" },
  config = conf.nvim_tree,
  requires = "kyazdani42/nvim-web-devicons",
}

ui["lewis6991/gitsigns.nvim"] = {
  event = { "BufRead", "BufNewFile" },
  config = conf.gitsigns,
  requires = { "nvim-lua/plenary.nvim", opt = true },
}

return ui
