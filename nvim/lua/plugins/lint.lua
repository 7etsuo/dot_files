return {
  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'

      -- Function to check if a command is available
      local function command_exists(cmd)
        local handle = io.popen('command -v ' .. cmd .. ' >/dev/null 2>&1 && echo "true" || echo "false"')
        local result = handle:read('*a'):gsub('%s+', '')
        handle:close()
        return result == 'true'
      end

      -- Set up linters for C based on availability
      lint.linters_by_ft = {
        c = {},
      }

      if command_exists 'clang-tidy' then
        table.insert(lint.linters_by_ft.c, 'clangtidy')
        lint.linters.clangtidy.args = {
          '--checks=*',
          '--warnings-as-errors=*',
        }
      else
        print 'Warning: clang-tidy not found. C linting will be limited.'
      end

      if command_exists 'cppcheck' then
        table.insert(lint.linters_by_ft.c, 'cppcheck')
        lint.linters.cppcheck.args = {
          '--enable=all',
          '--suppress=missingIncludeSystem',
          '--inconclusive',
          '--inline-suppr',
        }
      else
        print 'Warning: cppcheck not found. C linting will be limited.'
      end

      -- Disable default linters for other languages
      local default_linters = {
        'clojure',
        'dockerfile',
        'inko',
        'janet',
        'json',
        'markdown',
        'rst',
        'ruby',
        'terraform',
        'text',
      }
      for _, ft in ipairs(default_linters) do
        lint.linters_by_ft[ft] = nil
      end

      -- Create autocommand for linting with error handling
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          local buf = vim.api.nvim_get_current_buf()
          local ft = vim.bo[buf].filetype
          if lint.linters_by_ft[ft] and #lint.linters_by_ft[ft] > 0 then
            pcall(lint.try_lint)
          end
        end,
      })

      -- Keymap to manually trigger linting
      vim.keymap.set('n', '<leader>l', function()
        local buf = vim.api.nvim_get_current_buf()
        local ft = vim.bo[buf].filetype
        if lint.linters_by_ft[ft] and #lint.linters_by_ft[ft] > 0 then
          lint.try_lint()
        else
          print('No linters available for ' .. ft)
        end
      end, { desc = 'Trigger linting for current file' })
    end,
  },
}
