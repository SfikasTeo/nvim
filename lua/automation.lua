-- Automations

-- Remove search highlights after leaving search
vim.api.nvim_create_autocmd("CmdlineLeave", {
	pattern = "*",
	callback = function()
		vim.cmd("nohlsearch")
	end,
})
-- Remove trailing whitespaces on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = "*",
	callback = function()
		vim.api.nvim_exec(
			[[ %s/\s\+$//e ]],
			false
		)
	end,
})
-- Make created terminals modifiable & Enter on Insert
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	callback = function()
		vim.bo.modifiable = true
		vim.cmd("startinsert")
	end,
})
