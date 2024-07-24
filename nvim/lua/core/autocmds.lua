-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = {"*.c", "*.cpp", "*.h", "*.hpp"},
  callback = function()
    vim.fn.system("ctags -R .")
  end,
})
