local config = {}

function config.vim_vista()
  vim.g["vista#renderer#enable_icon"] = 1
  vim.g.vista_disable_statusline = 1
  vim.g.vista_default_executive = "ctags"
  vim.g.vista_echo_cursor_strategy = "floating_win"
  vim.g.vista_vimwiki_executive = "markdown"
  vim.g.vista_executive_for = {
    vimwiki = "markdown",
    pandoc = "markdown",
    markdown = "toc",
    typescript = "nvim_lsp",
    typescriptreact = "nvim_lsp",
    cpp = "nvim_lsp",
    lua = "nvim_lsp",
  }
end

function config.toggleterm()
  require("toggleterm").setup {
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
    open_mapping = [[<M-=>]],
    hide_numbers = true,
    shade_terminals = true,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "horizontal",
    close_on_exit = true,
    shell = vim.o.shell,
  }
  local Terminal = require("toggleterm.terminal").Terminal
  local lazygit = Terminal:new {
    cmd = "lazygit",
    dir = "git_dir",
    direction = "float",
    float_opts = {
      border = "double",
    },
    on_open = function(term)
      vim.cmd "startinsert!"
      -- vim.api.nvim_buf_set_keymap(
      --   term.bufnr,
      --   "n",
      --   "q",
      --   "<cmd>close<CR>",
      --   { noremap = true, silent = true }
      -- )
    end,
    -- on_close = function(term)
    --   vim.cmd "Closing terminal"
    -- end,
  }
  function _lazygit_toggle()
    lazygit:toggle()
  end
  vim.api.nvim_set_keymap(
    "n",
    "<leader>g",
    "<cmd>lua _lazygit_toggle()<CR>",
    { noremap = true, silent = true }
  )
end

function config.bqf()
  require("bqf").setup {
    preview = {
      auto_preview = false,
    },
  }
end

function config.vim_grepper()
  vim.api.command "aug Grepper"
  vim.api.command "au!"
  vim.api.command "au User Grepper call setqflist([], 'r', {'context': {'bqf': {'pattern_hl': histget('/')}}}) | botright copen"
  vim.api.command "aug END"

  vim.cmd [[command! Todo :Grepper -tool git -query '(TODO|FIXME)']]

  vim.g.grepper = {
    { open = 0 },
    { quickfix = 1 },
    { searchreg = 1 },
    { highlight = 0 },
  }
end

return config
