local config = {}

function config.autopairs()
	local npairs = require("nvim-autopairs")
	npairs.setup({
		enable_check_bracket_line = false,
    check_ts = true,
	})
	local parenthesis_rule = npairs.get_rule("(")
	parenthesis_rule:with_pair(function()
		if vim.fn.pumvisible() then
			vim.cmd([[ call timer_start(0, { -> luaeval('require"compe"._close()')})]])
		end
		return true
	end)
end

function config.nvim_colorizer()
	require("colorizer").setup({
		css = { rgb_fn = true },
		scss = { rgb_fn = true },
		sass = { rgb_fn = true },
		stylus = { rgb_fn = true },
		vim = { names = true },
		tmux = { names = false },
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		html = {
			mode = "foreground",
		},
	})
end

function config.vim_cursorwod()
	vim.api.nvim_command("augroup user_plugin_cursorword")
	vim.api.nvim_command("autocmd!")
	vim.api.nvim_command("autocmd FileType NvimTree,lspsagafinder,dashboard,vista let b:cursorword = 0")
	vim.api.nvim_command("autocmd WinEnter * if &diff || &pvw | let b:cursorword = 0 | endif")
	vim.api.nvim_command("autocmd InsertEnter * let b:cursorword = 0")
	vim.api.nvim_command("autocmd InsertLeave * let b:cursorword = 1")
	vim.api.nvim_command("augroup END")
end

return config
