-- Automations

-- Make created terminals modifiable & Enter on Insert
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	callback = function()
		vim.bo.modifiable = true
		vim.cmd("startinsert")
	end,
})

-- Remove trailing whitespaces & Ensure the last line is empty
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = "*",
    callback = function()
        -- Remove trailing whitespaces
        vim.api.nvim_exec(
            [[ %s/\s\+$//e ]],
            false
        )

        -- Ensure the last line is empty (adds a new line if the last line is not empty)
--        local bufnr = vim.api.nvim_get_current_buf()
--        local line_count = vim.api.nvim_buf_line_count(bufnr)
--        local last_line = vim.api.nvim_buf_get_lines(bufnr, line_count-1, line_count, false)[1]
--
--        if last_line ~= "" then
--            vim.api.nvim_buf_set_lines(bufnr, line_count, line_count, false, {""})
--        end
    end,
})

