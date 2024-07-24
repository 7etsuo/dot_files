return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',
    { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
    'folke/neodev.nvim',
  },
  config = function()
    require('mason').setup()
    require('mason-lspconfig').setup({
      ensure_installed = { 'clangd' },
    })

    local lspconfig = require('lspconfig')

    lspconfig.clangd.setup({
      cmd = {
        "clangd",
        "--background-index",
        "--suggest-missing-includes",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--fallback-style=none", -- This tells clangd to only use .clang-format
      },
    })

    local on_attach = function(client, bufnr)
      -- (Keep your existing keymaps here)

      -- Remove the format on save functionality
      -- Instead, we'll set up a command to format using clang-format directly
      vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.cmd("silent !clang-format -i " .. vim.fn.expand("%"))
        vim.cmd("edit") -- Reload the file
      end, { desc = 'Format current buffer with clang-format' })
    end

    -- Set up lspconfig for each language
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    local servers = { 'clangd' }
    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }
    end
  end
}
