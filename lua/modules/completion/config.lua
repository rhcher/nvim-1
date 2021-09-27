-- local handlers = require "vim.lsp.handlers"
local config = {}

function config.nvim_lsp()
  require "modules.completion.lspconfig"
end

function config.nvim_cmp()
  local cmp = require "cmp"
  local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end
  cmp.setup {
    completion = {
      autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged },
      completeopt = "menu,menuone,noselect",
      keyword_pattern = [[\k\+]],
    },
    experimental = {
      ghost_text = true,
    },
    documentation = {
      border = "single",
    },
    sorting = {
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.kind,
        cmp.config.compare.length,
        cmp.config.compare.sort_text,
        cmp.config.compare.order,
      },
    },
    -- You should change this example to your chosen snippet engine.
    snippet = {
      expand = function(args)
        -- You must install `vim-vsnip` if you set up as same as the following.
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    -- You must set mapping.
    mapping = {
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<C-y>"] = cmp.mapping.confirm {
        select = true,
        behavior = cmp.ConfirmBehavior.Replace,
      },
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.confirm { select = true, behavior = cmp.ConfirmBehavior.Replace }
        elseif vim.fn["vsnip#available"]() == 1 then
          vim.fn.feedkeys(t "<Plug>(vsnip-expand-or-jump)", "")
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
    },
    -- You should specify your *installed* sources.
    sources = {
      { name = "nvim_lsp" },
      { name = "vsnip" },
      {
        name = "buffer",
        opts = {
          keyword_pattern = [[\k\+]],
        },
      },
      { name = "nvim_lua" },
      { name = "path" },
      { name = "calc" },
    },
    formatting = {
      format = function(entry, vim_item)
        vim_item.menu = ({
          nvim_lsp = "[LSP]",
          buffer = "[Buf]",
          vsnip = "[Vsnip]",
          nvim_lua = "[Lua]",
        })[entry.source.name]
        return vim_item
      end,
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
