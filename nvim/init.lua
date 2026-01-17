require("config.options")

require("config.keymaps")

require("config.lazy")

vim.cmd([[
  autocmd VimEnter * silent !kitty @ set-spacing padding=0
  autocmd VimLeave * silent !kitty @ set-spacing padding=10
  autocmd VimResume * silent !kitty @ set-spacing padding=0
  autocmd VimSuspend * silent !kitty @ set-spacing padding=10
]])

vim.api.nvim_set_hl(0, "Cursor", { blend = 100, reverse = true })

-- this is to hide bufferline / cursor on dashboard
vim.api.nvim_create_autocmd("FileType", {
	pattern = "snacks_dashboard",
	callback = function()
		vim.o.showtabline = 0
		vim.opt.guicursor:append("a:Cursor/lCursor")
	end,
})

-- and to put it back
vim.api.nvim_create_autocmd("BufLeave", {
	pattern = "*",
	callback = function()
		if vim.bo.filetype == "snacks_dashboard" then
			vim.opt.guicursor:remove("a:Cursor/lCursor")
			vim.o.showtabline = 2
		end
	end,
})
