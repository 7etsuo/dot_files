local M = {}

local function has_clang_format()
  return vim.fn.executable('clang-format') == 1
end

local function format_buffer()
  if not has_clang_format() then
    vim.notify("clang-format not found. Please install it.", vim.log.levels.WARN)
    return
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local filename = vim.api.nvim_buf_get_name(bufnr)
  local cmd = string.format("clang-format -i %s", vim.fn.shellescape(filename))
  
  vim.fn.system(cmd)
  if vim.v.shell_error ~= 0 then
    vim.notify("Error running clang-format", vim.log.levels.ERROR)
    return
  end
  
  vim.cmd("checktime") -- Reload the file without prompting
end

M.setup = function()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp" },
    callback = function()
      if has_clang_format() then
        -- Use clang-format for '=' operator
        vim.bo.equalprg = "clang-format"
        
        -- Map gg=G to use clang-format
        vim.keymap.set('n', 'gg=G', format_buffer, {
          buffer = true,
          desc = 'Format entire file with clang-format'
        })
        
        -- Optional: Set up format on save
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = 0,
          callback = format_buffer,
        })
      else
        vim.notify("clang-format not found. Some C/C++ formatting features will be disabled.", vim.log.levels.WARN)
      end
    end
  })
end

return M
