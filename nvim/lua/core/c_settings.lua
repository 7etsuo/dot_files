local M = {}

M.setup = function()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp" },
    callback = function()
      -- Use clang-format for '=' operator
      vim.bo.equalprg = "clang-format"

      -- Map gg=G to use clang-format
      vim.keymap.set('n', 'gg=G', function()
        vim.cmd("silent !clang-format -i " .. vim.fn.expand("%"))
        vim.cmd("edit") -- Reload the file
      end, { buffer = true, desc = 'Format entire file with clang-format' })

      -- Optional: Set up format on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = 0,
        callback = function()
          vim.cmd("silent !clang-format -i " .. vim.fn.expand("%"))
        end,
      })
    end
  })
end

return M
