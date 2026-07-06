local prose_textwidth = 80

local function in_table_row()
	return vim.api.nvim_get_current_line():match("^%s*|") ~= nil
end

local function update_textwidth()
	vim.opt_local.textwidth = in_table_row() and 0 or prose_textwidth
end

vim.opt_local.textwidth = prose_textwidth
vim.opt_local.formatoptions:append("t")
update_textwidth()

local group = vim.api.nvim_create_augroup("MarkdownTextwidth", { clear = false })

vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "InsertEnter" }, {
	group = group,
	buffer = 0,
	callback = update_textwidth,
})
