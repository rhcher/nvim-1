local api = vim.api
local util = require "lspconfig/util"
local lspconfig = require "lspconfig"
local global = require "core.global"
local format = require "modules.completion.format"

if not packer_plugins["lspsaga.nvim"].loaded then
  vim.cmd [[packadd lspsaga.nvim]]
end

local saga = require "lspsaga"
saga.init_lsp_saga {
  code_action_icon = "💡",
}

require("cmp_nvim_lsp").setup {}
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = {
  "markdown",
}
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport =
  true
capabilities.textDocument.completion.completionItem.tagSupport = {
  valueSet = { 1 },
}
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

function _G.reload_lsp()
  vim.lsp.stop_client(vim.lsp.get_active_clients())
  vim.cmd [[edit]]
end

function _G.open_lsp_log()
  local path = vim.lsp.get_log_path()
  vim.cmd("edit " .. path)
end

vim.cmd "command! -nargs=0 LspLog call v:lua.open_lsp_log()"
vim.cmd "command! -nargs=0 LspRestart call v:lua.reload_lsp()"

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    -- Enable underline, use default values
    underline = false,
    -- Enable virtual text, override spacing to 4
    virtual_text = false,
    signs = {
      enable = true,
      priority = 20,
    },
    -- Disable a feature
    update_in_insert = false,
  }
)

local enhance_attach = function(client, bufnr)
  if client.resolved_capabilities.document_formatting then
    format.lsp_before_save()
  end
  -- Set autocommands conditional on server_capabilities
  -- if client.resolved_capabilities.document_highlight then
  --   -- vim.g.cursorword_highlight = 1
  --   vim.api.nvim_exec(
  --     [[
  -- augroup lsp_document_highlight
  -- autocmd! * <buffer>
  -- autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
  -- autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
  -- augroup END
  -- ]],
  --     false
  --   )
  -- end
  local ext = vim.fn.expand "%:e"
  if ext == "lua" then
    vim.api.nvim_command "au BufWritePre *.lua Format"
  end
  -- if client.resolved_capabilities.code_lens then
  --   vim.cmd [[
  --   augroup CodeLens
  --     au!
  --     au InsertEnter,InsertLeave * lua vim.lsp.codelens.refresh()
  --   augroup END
  --   ]]
  -- end
  api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  require("lsp_signature").on_attach {
    bind = true,
    handler_opts = {
      border = "double",
    },
    use_lspsaga = false,
    floating_window = false,
    fix_pos = true,
    hint_enable = true,
    hi_parameter = "Search",
    extra_trigger_char = { "(", "," },
  }
end

lspconfig.gopls.setup {
  cmd = { "gopls", "--remote=auto" },
  on_attach = enhance_attach,
  capabilities = capabilities,
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
  },
}

lspconfig.sumneko_lua.setup {
  on_attach = enhance_attach,
  capabilities = capabilities,
  commands = {
    Format = {
      function()
        require("stylua-nvim").format_file()
      end,
    },
  },
  cmd = {
    "/home/rhcher/workspace/lua-language-server/bin/Linux/lua-language-server",
    "/home/rhcher/workspace/lua-language-server/main.lua",
  },
  settings = {
    Lua = {
      diagnostics = {
        enable = true,
        globals = { "vim", "packer_plugins" },
      },
      completion = {
        callSnippet = "Replace",
      },
      runtime = { version = "LuaJIT" },
      workspace = {
        library = vim.list_extend(
          { [vim.fn.expand "$VIMRUNTIME/lua"] = true },
          {}
        ),
      },
    },
  },
  flags = {
    debounce_text_changes = 150,
  },
}

-- lspconfig.tsserver.setup({
-- 	on_attach = function(client)
-- 		client.resolved_capabilities.document_formatting = false
-- 		enhance_attach(client)
-- 	end,
-- })

-- lspconfig.clangd.setup {
--   on_attach = enhance_attach,
--   capabilities = capabilities,
--   cmd = {
--     "clangd",
--     "--background-index",
--     "--suggest-missing-includes",
--     "--clang-tidy",
--     "--header-insertion=iwyu",
--   },
--   flags = {
--     debounce_text_changes = 150,
--   },
-- }

lspconfig.ccls.setup {
  on_attach = enhance_attach,
  capabilities = capabilities,
  cmd = { "ccls" },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
  root_dir = function(fname)
    return util.root_pattern(
      "compile_commands.json",
      ".git",
      ".ccls-root",
      ".ccls"
    )(fname) or util.path.dirname(fname)
  end,
  init_options = {
    index = {
      trackDependency = 2,
      initialNoLinkage = true,
    },
    cache = {
      directory = "/tmp/ccls-cache/",
      hierarchicalPath = true,
    },
  },
  flags = {
    debounce_text_changes = 150,
  },
}

lspconfig.rust_analyzer.setup {
  on_attach = enhance_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

-- lspconfig.pyls_ms.setup({
-- 	capabilities = capabilities,
-- 	cmd = { "dotnet", "exec", global.home .. "/.emacs.d/.local/etc/lsp/mspyls/Microsoft.Python.LanguageServer.dll" },
-- })

lspconfig.racket_langserver.setup {
  on_attach = enhance_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

lspconfig.pylsp.setup {
  on_attach = enhance_attach,
  capabilities = capabilities,
  filetypes = { "python" },
  settings = {
    pylsp = {
      plugins = {
        pylint = { enabled = false, executable = "pylint" },
        pyflakes = { enabled = false },
        pycodestyle = { enabled = false },
        jedi_completion = {
          enable = true,
          fuzzy = false,
          include_params = false,
          include_class_objects = true,
          eager = true,
        },
        pyls_isort = { enabled = true },
        pylsp_mypy = { enabled = true },
      },
    },
  },
  flags = {
    debounce_text_changes = 150,
  },
}

lspconfig.hls.setup {
  on_attach = enhance_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

local servers = {
  "dockerls",
  "bashls",
}

for _, server in ipairs(servers) do
  lspconfig[server].setup {
    on_attach = enhance_attach,
    flags = {
      debounce_text_changes = 150,
    },
  }
end
