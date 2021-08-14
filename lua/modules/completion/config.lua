-- local handlers = require "vim.lsp.handlers"
local config = {}

function config.nvim_lsp()
  require "modules.completion.lspconfig"
end

function config.nvim_compe()
  require("compe").setup {
    enabled = true,
    debug = false,
    min_length = 1,
    preselect = "always",
    allow_prefix_unmatch = false,
    documentation = {
      border = "rounded", -- the border option is the same as `|help nvim_open_win|`
      winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
      max_width = 60,
      min_width = 30,
      max_height = math.floor(vim.o.lines * 0.3),
      min_height = 1,
    },
    source = {
      path = true,
      buffer = true,
      calc = true,
      vsnip = true,
      nvim_lsp = {
        sort = false,
      },
      nvim_lua = true,
      spell = false,
      tags = true,
      snippets_nvim = false,
    },
  }
end

function config.vim_vsnip()
  vim.g.vsnip_snippet_dir = os.getenv "HOME" .. "/.config/nvim/snippets"
end

function config.telescope()
  if not packer_plugins["plenary.nvim"].loaded then
    vim.cmd [[packadd plenary.nvim]]
    vim.cmd [[packadd popup.nvim]]
    vim.cmd [[packadd telescope-fzy-native.nvim]]
  end
  require("telescope").setup {
    defaults = {
      prompt_prefix = "🔭 ",
      layout_config = {
        prompt_position = "top",
      },
      selection_caret = " ",
      sorting_strategy = "ascending",
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    },
    extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      },
    },
  }
  require("telescope").load_extension "fzy_native"
  require("telescope").load_extension "dotfiles"
  require("telescope").load_extension "gosource"
end

function config.vim_sonictemplate()
  vim.g.sonictemplate_postfix_key = "<C-,>"
  vim.g.sonictemplate_vim_template_dir = os.getenv "HOME"
    .. "/.config/nvim/template"
end

function config.smart_input()
  require("smartinput").setup {
    ["go"] = { ";", ":=", ";" },
  }
end

function config.emmet()
  vim.g.user_emmet_complete_tag = 0
  vim.g.user_emmet_install_global = 0
  vim.g.user_emmet_install_command = 0
  vim.g.user_emmet_mode = "i"
end

return config
