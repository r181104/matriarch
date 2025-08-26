return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local fzf = require("fzf-lua")
		fzf.setup({
			winopts = {
				height = 0.9,
				width = 0.9,
				-- preview = {
				-- 	hidden = "hidden",
				-- },
			},
			keymap = {
				fzf = {
					["tab"] = "down",
					["shift-tab"] = "up",
					["ctrl-p"] = "toggle-preview",
				},
			},
		})
	end,
}
