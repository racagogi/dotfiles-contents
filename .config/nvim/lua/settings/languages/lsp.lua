vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local opts = { win = ev.win, buf = ev.buf }
		vim.api.nvim_set_option_value("formatexpr", "v:lua.vim.lsp.formatexpr()", opts)
		vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", opts)
		vim.api.nvim_set_option_value("tagfunc", "v:lua.vim.lsp.tagfunc", opts)
		opts = { buffer = ev.buf }
		vim.keymap.set('n', '<space>d', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', '<space>n', vim.lsp.buf.rename, opts)
		vim.keymap.set('n', '<space>h', function ()
			vim.lsp.buf.hover()
		end, opts)
		vim.keymap.set('n', '<space>r', vim.lsp.buf.references, opts)
		vim.keymap.set('n', '<space>i', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', '<space>D', vim.lsp.buf.declaration, opts)
		vim.keymap.set({ 'n', 'v' }, '<space>a', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', '<space>r', vim.lsp.buf.references, opts)
		vim.keymap.set('n', '<space>s', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', '<space>w', vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set('n', '<space>f', function()
			vim.lsp.buf.format { async = true }
		end, opts)
	end,
})

vim.keymap.del('n', ']d')
vim.keymap.del('n', '[d')

vim.keymap.set('n', ']d', function()
	vim.diagnostic.goto_next({ float = true })
end, { desc = 'Jump to the next diagnostic' })

vim.keymap.set('n', '[d', function()
	vim.diagnostic.goto_prev({ float = true })
end, { desc = 'Jump to the previous diagnostic' })

vim.api.nvim_create_user_command('LspLog',
	function()
		vim.cmd(string.format('tabnew %s', vim.lsp.get_log_path()))
	end,
	{
		desc = 'Opens the Nvim LSP client log.',
	}
)

vim.diagnostic.config({
	float = {
		border = "rounded"
	},
})

local M = {}

function M.setup(filetype, name, root_files, cmd, settings)
	vim.api.nvim_create_autocmd('FileType', {
		pattern = filetype,
		callback = function(args)
			local root_dir = vim.fs.root(args.buf, root_files)
			if vim.bo.buftype == "" then
				vim.lsp.start(vim.tbl_deep_extend('keep', {
					name = name,
					cmd = cmd,
					root_dir = root_dir,
					capabilities = vim.tbl_deep_extend('keep', vim.lsp.protocol.make_client_capabilities(),
						require('cmp_nvim_lsp').default_capabilities()),
					handlers = {
						['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
							style = "minmal",
							max_width = 80,
							border = "rounded",
							focuse = true,
						})
					}
				}, settings))
			end
		end
	})
end

return M
