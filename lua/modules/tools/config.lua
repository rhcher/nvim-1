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
end

return config
