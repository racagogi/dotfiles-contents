return {
	"ellisonleao/gruvbox.nvim",
	priority = 1000,
	config = function()
		require("gruvbox").setup({
			contrast = "soft",
			overrides = {
				FloatBorder = { link = "bg" },
				NormalFloat = { link = "bg" }
			},
		})
		vim.opt.background = "light"
		vim.cmd [[colorscheme gruvbox]]
	end
}