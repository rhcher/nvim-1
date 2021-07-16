local api = vim.api
local util = require("lspconfig/util")
local lspconfig = require("lspconfig")
local global = require("core.global")
local format = require("modules.completion.format")

if not packer_plugins["lspsaga.nvim"].loaded then
	vim.cmd([[packadd lspsaga.nvim]])
end

local saga = require("lspsaga")
saga.init_lsp_saga({
	code_action_icon = "💡",
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

function _G.reload_lsp()
	vim.lsp.stop_client(vim.lsp.get_active_clients())
	vim.cmd([[edit]])
end

function _G.open_lsp_log()
	local path = vim.lsp.get_log_path()
	vim.cmd("edit " .. path)
end

vim.cmd("command! -nargs=0 LspLog call v:lua.open_lsp_log()")
vim.cmd("command! -nargs=0 LspRestart call v:lua.reload_lsp()")

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	-- Enable underline, use default values
	underline = true,
	-- Enable virtual text, override spacing to 4
	virtual_text = true,
	signs = {
		enable = true,
		priority = 20,
	},
	-- Disable a feature
	update_in_insert = false,
})

local enhance_attach = function(client, bufnr)
	if client.resolved_capabilities.document_formatting then
		format.lsp_before_save()
	end
	api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

lspconfig.gopls.setup({
	cmd = { "gopls", "--remote=auto" },
	on_attach = enhance_attach,
	capabilities = capabilities,
	init_options = {
		usePlaceholders = true,
		completeUnimported = true,
	},
})

lspconfig.sumneko_lua.setup({
	commands = {
		Format = {
			function()
				require("stylua-nvim").format_file()
			end,
		},
	},
	capabilities = capabilities,
	cmd = {
		global.home .. "/lua-language-server/bin/Linux/lua-language-server",
		"-E",
		global.home .. "/lua-language-server/main.lua",
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
				library = vim.list_extend({ [vim.fn.expand("$VIMRUNTIME/lua")] = true }, {}),
			},
		},
	},
})

lspconfig.tsserver.setup({
	on_attach = function(client)
		client.resolved_capabilities.document_formatting = false
		enhance_attach(client)
	end,
})

-- lspconfig.clangd.setup {
--   capabilities = capabilities,
--   cmd = {
--     "clangd",
--     "--background-index",
--     "--suggest-missing-includes",
--     "--clang-tidy",
--     "--header-insertion=iwyu",
--   },
-- }

lspconfig.ccls.setup({
	capabilities = capabilities,
	cmd = { "ccls" },
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
	root_dir = function(fname)
		return util.root_pattern("compile_commands.json", ".git", ".ccls-root", ".ccls")(fname)
			or util.path.dirname(fname)
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
	on_attach = function()
		require("lsp_signature").on_attach({
			bind = true,
			handler_opts = {
				border = "double",
			},
			use_lspsaga = false,
			floating_window = true,
			fix_pos = true,
			hint_enable = true,
			hi_parameter = "Search",
			extra_trigger_char = { "(", "," },
		})
	end,
})

lspconfig.rust_analyzer.setup({
	capabilities = capabilities,
})

-- lspconfig.pyls_ms.setup({
-- 	capabilities = capabilities,
-- 	cmd = { "dotnet", "exec", global.home .. "/.emacs.d/.local/etc/lsp/mspyls/Microsoft.Python.LanguageServer.dll" },
-- })

lspconfig.pylsp.setup({
  filetypes = {'python'},
  root_dir = function (fname)
    return util.find_git_ancestor(fname) or vim.loop.os_homedir()
  end,
	settings = {
		pylsp = {
			plugins = {
				pylint = { enabled = false, executable = "pylint" },
				pyflakes = { enabled = false },
				pycodestyle = { enabled = false },
				jedi_completion = { fuzzy = false },
				pyls_isort = { enabled = true },
				pylsp_mypy = { enabled = true },
			},
		},
	},
	flags = {
		debounce_text_changes = 200,
	},
})

local servers = {
	"dockerls",
	"bashls",
	"hls",
  "pylsp",
}

for _, server in ipairs(servers) do
	lspconfig[server].setup({
		on_attach = enhance_attach,
	})
end
