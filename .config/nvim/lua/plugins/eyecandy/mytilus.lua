return {
	'racagogi/mytilus',
	priority = 1000,
	lazy = false,
	config = function()
		require("mytilus").setup(
			{
				theme    = 'light',
				options  = {
					
				},
				overides = {}
			}
		)
		vim.cmd [[colorscheme mytilus]]
	end
}
