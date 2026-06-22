require('nvim-treesitter').setup({
    highlight = { enable = true },
    indent = { enable = true },
    init = function()
        local ensureInstalled = {
         "python", "lua", "vim", "options", "bash", "go", "dockerfile", "json", "yaml",
        }
        local alreadyInstalled = require('nvim-treesitter.config').get_installed()
        local parsersToInstall = vim.iter(ensureInstalled)
            :filter(function(parser)
                return not vim.tbl_contains(alreadyInstalled, parser)
            end)
            :totable()
        require('nvim-treesitter').install(parsersToInstall)
end
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


-- lsp keymaps (only those NOT provided by neovim 0.11+ defaults)
-- Default LSP keymaps in Neovim 0.11+ (no need to set manually):
--   K          hover
--   grn        rename
--   gra        code action
--   grr        references
--   gri        implementation
--   gO         document symbols
--   [d / ]d    diagnostic prev/next
--   <C-S>      signature help (insert mode)
vim.keymap.set('n', 'grd', vim.lsp.buf.definition, {desc = "go: Definition"})
vim.keymap.set('n', 'grD', vim.lsp.buf.declaration, {desc = "go: Declaration"})
vim.keymap.set('n', 'gro', vim.lsp.buf.type_definition, {desc = "go: Type Definition"})

-- diagnostics
vim.keymap.set('n', '<leader>dw', vim.diagnostic.open_float, { desc = "Floating diagnostic" })
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = "Diagnostic list" })
local servers = { "ty", "gopls", "bashls", "lua_ls", }

require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = servers,
})

vim.lsp.enable(servers)

require("mason-tool-installer").setup({
    ensure_installed = { "deno", "debugpy" },
    auto_update = true,
    run_on_start = true,
})

do
    local dir = vim.fs.joinpath(vim.fn.stdpath('data'), 'site/pack/core/opt/blink.cmp')
    local lib = vim.fs.joinpath(dir, 'target/release/libblink_cmp_fuzzy.so')
    local src = vim.fs.joinpath(dir, 'Cargo.toml')
    if vim.fn.getftime(src) > vim.fn.getftime(lib) then
        vim.system({'cargo', 'build', '--release'}, {cwd = dir}, function(r)
            local msg = r.code == 0 and 'blink.cmp: fuzzy binary built' or 'blink.cmp: build failed'
            vim.notify(msg, r.code == 0 and vim.log.levels.INFO or vim.log.levels.ERROR)
        end)
    end
end

require("blink.cmp").setup({
    keymap = { preset = 'default' },
    appearance = {
        nerd_font_variant = 'mono'
    },
    completion = {
        documentation = { auto_show = false }
    },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    fuzzy = { implementation = "prefer_rust" },
})

require("luasnip.loaders.from_vscode").lazy_load()
