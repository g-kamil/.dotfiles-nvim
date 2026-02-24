local keymaps = vim.keymap

require('nvim-treesitter').setup({
    ensure_installed = { "python", "lua", "vim", "options.", "bash", "go", "dockerfile", "json", "yaml" },
    highlight = { enable = true },
    indent = { enable = true },
})

-- lsp
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = { border = 'rounded', source = 'always' },
})

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf, silent = true}

    keymaps.set('n', 'gd', vim.lsp.buf.definition, opts)
    keymaps.set('n', 'gD', vim.lsp.buf.declaration, opts)
    keymaps.set('n', 'gi', vim.lsp.buf.implementation, opts)
    keymaps.set('n', 'go', vim.lsp.buf.type_definition, opts)
    keymaps.set('n', 'gr', vim.lsp.buf.references, opts)
    keymaps.set('n', 'K', vim.lsp.buf.hover, opts)
    keymaps.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    keymaps.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  end,
})

local servers = { "ty", "gopls", "bashls", "lua_ls", }

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = servers,
    handlers = {
        function(server_name) vim.lsp.enable(server_name) end,
    }
})
require("mason-tool-installer").setup({
    ensure_installed = { "deno", "debugpy" },
    auto_update = true,
    run_on_start = true,
})

