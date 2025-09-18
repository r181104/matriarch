return {
	"neovim/nvim-lspconfig",
	config = function()
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		local ok, blink_cmp = pcall(require, "blink.cmp")
		if ok then
			capabilities = blink_cmp.get_lsp_capabilities(capabilities)
		end

		local function setup(server, opts)
			opts = opts or {}
			opts.capabilities = capabilities
			opts.on_attach = on_attach

			vim.lsp.config[server] = opts

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "*",
				callback = function(ev)
					local bufnr = ev.buf
					local ft = vim.bo[bufnr].filetype
					local config = vim.lsp.config[server]
					if vim.tbl_contains(config.filetypes or {}, ft) then
						vim.lsp.start(config, { bufnr = bufnr })
					end
				end,
			})
		end

		setup("lua_ls", {
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
				},
			},
		})

		setup("pyright")
		setup("jdtls")
		setup("rust_analyzer")
		setup("vtsls")
		setup("tailwindcss")
	end,
}
