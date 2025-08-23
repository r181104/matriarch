return {
	"rcarriga/nvim-notify",
	config = function()
		require("notify").setup({ background_colour = "#000000" })
		vim.notify = require("notify")
		vim.notify("Hello What we doing today")
	end,
}
