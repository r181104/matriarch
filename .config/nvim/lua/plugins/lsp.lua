return {
	"neovim/nvim-lspconfig",
	config = function()
		local lspconfig = require("lspconfig")
		-- 🔧 integrate blink.cmp
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		local ok, blink_cmp = pcall(require, "blink.cmp")
		if ok then
			capabilities = blink_cmp.get_lsp_capabilities(capabilities)
		end
		-- Helper function so you don't repeat boilerplate
		local function setup(server, opts)
			opts = opts or {}
			opts.capabilities = capabilities
			opts.on_attach = on_attach
			lspconfig[server].setup(opts)
		end
		-- ✅ Enable servers here
		setup("lua_ls", {
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
				},
			},
		})
		setup("pyright")
		setup("rust_analyzer")
	end,
}
