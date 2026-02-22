-- =============== --
-- Basic Settings  --
-- =============== --
local options = vim.o
local keymaps = vim.keymap


options.number = true
options.relativenumber = true
options.signcolumn = "yes" -- adds column on left for "signals"
options.wrap = false
options.tabstop = 4
options.shiftwidth = 4 -- 4 spaces when tab
options.expandtab = true -- change tab to spaces
options.smartindent = true -- automatic indentation
options.ignorecase = true -- ignore case when searching
options.smartcase = true -- extends above (if you write UpperCase)
options.cursorline = true -- highlight line with cursor
options.swapfile = false
options.winborder = "rounded"
options.laststatus = 3 -- global statusline for all windows
options.termguicolors = true -- for some 'coloring' plugins
options.scrolloff = 8 -- Keep 8 lines visible when scrolling
options.updatetime = 250 -- Faster update time for CursorHold events

-- map leader key
vim.g.mapleader = " "
keymaps.set('n', 'q', '<Nop>', { noremap = true, silent = true }) -- unmap q as it's fucking annoying
keymaps.set('n', 's', '<Nop>', { noremap = true, silent = true }) -- unmap s so it's not insert mode

-- standard keymaps
keymaps.set('n', '<leader>o', ':update<CR> :source<CR>', { desc = "Update and Source current buffer" })
keymaps.set('n', '<leader>w', ':write<CR>', { desc = "Save buffer" })
keymaps.set('n', '<leader>qq', ':quit<CR>', { desc = "Quit" })
keymaps.set('n', '<leader>jj', ':wq<CR>', { desc = "Write&Quit" })
keymaps.set('n', '<Tab>', ':tabnext<CR>', { desc = "Next tab" })
keymaps.set('n', '<S-Tab>', ':tabprevious<CR>' , { desc = "Prev tab" })
keymaps.set('n', '<leader>sh', ':split<CR>', { desc = "Split Horizontal" })
keymaps.set('n', '<leader>sv', ':vsplit<CR>', { desc = "Split Vertical" })
keymaps.set('n', '<C-h>', '<C-w>h', { desc = "Go to Left Window" })
keymaps.set('n', '<C-j>', '<C-w>j', { desc = "Go to Lower Window" })
keymaps.set('n', '<C-k>', '<C-w>k', { desc = "Go to Upper Window" })
keymaps.set('n', '<C-l>', '<C-w>l', { desc = "Go to Right Window" })
keymaps.set('n', '<M-Up>', ':resize -2<CR>' ,{ desc = "Resize window 2px up"})
keymaps.set('n', '<M-Down>', ':resize +2<CR>', { desc = "Resize window 2px down"})
keymaps.set('n', '<M-Left>', ':vertical resize -2<CR>', { desc = "Resize window 2px left"})
keymaps.set('n', '<M-Right>', ':vertical resize +2<CR>', { desc = "Resize window 2px right"})

-- system clipboard
keymaps.set({'n', 'v', 'x'}, '<leader>y', '"+y<CR>', { desc = "yank to system clipboard" })
keymaps.set({'n', 'v', 'x'}, '<leader>d', '"+d<CR>', { desc = "delete to system clipboard" })
keymaps.set({'n', 'v' }, '<leader>p', '"+p<CR>', { desc = "paste from system clipboard" })

-- =============== --
--     styling     --
-- =============== --

vim.pack.add({{ src = "https://github.com/neanias/everforest-nvim" },})
vim.cmd("colorscheme everforest")

-- =============== --
-- plugins install --
-- =============== --
vim.pack.add({
        -- "gui" elements
		{ src = "https://github.com/stevearc/oil.nvim" }, -- for file managing
		{ src = "https://github.com/echasnovski/mini.pick" }, -- for file picking 
		{ src = "https://github.com/mg979/vim-visual-multi" }, -- multicursor; C_down/up; S_arrows; C_N
        { src = "https://github.com/nvim-treesitter/nvim-treesitter" }, -- Syntax highlighting (AST)
        { src = "https://github.com/folke/which-key.nvim" }, -- displays keybinding
        -- lsp
		{ src = "https://github.com/neovim/nvim-lspconfig" },
        { src = "https://github.com/mason-org/mason.nvim" },
        { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
        { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" }, -- for auto tool instalation
        -- autocompletion
        { src = "https://github.com/hrsh7th/nvim-cmp" },
        { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
        { src = "https://github.com/hrsh7th/cmp-buffer" },
        { src = "https://github.com/hrsh7th/cmp-path" },
        -- terminal
        { src = "https://github.com/akinsho/toggleterm.nvim" },
        { src = "https://github.com/kdheepak/lazygit.nvim" },
        { src = "https://github.com/mgierada/lazydocker.nvim" },
        -- markdown
        { src = "https://github.com/OXY2DEV/markview.nvim" },
        -- debugging
        { src = "https://github.com/mfussenegger/nvim-dap" },
        { src = "https://github.com/mfussenegger/nvim-dap-python" },
        { src = "https://github.com/rcarriga/nvim-dap-ui" },
        { src = "https://github.com/nvim-neotest/nvim-nio" },          -- required by dap-ui
        { src = "https://github.com/theHamsta/nvim-dap-virtual-text" }, -- display dap info directly in buffer
})

-- ============= --
-- plugin setup  --
-- ============= --

require("mini.pick").setup()

require("oil").setup({
    view_options = { show_hidden = true },
    float = { padding = 8, max_width = 90, max_height = 0 }
})

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

-- debugging
local dap = require("dap")
local dapui = require("dapui")

require("dap-python").setup(vim.fn.exepath("debugpy-adapter"))
require("nvim-dap-virtual-text").setup()
dapui.setup({
    layouts = {
        {
            elements = {
                { id = "scopes", size = 0.35 },
                { id = "breakpoints", size = 0.15 },
                { id = "stacks", size = 0.25 },
                { id = "watches", size = 0.25 },
            },
            position = "left",
            size = 40,
        },
        {
            elements = {
                { id = "repl", size = 0.5 },
                { id = "console", size = 0.5 },
            },
            position = "bottom",
            size = 10,
        },
    },
})

vim.fn.sign_define("DapBreakpoint", {
    text = "",
    texthl = "DiagnosticSignError",
    linehl = "",
    numhl = "",
})

vim.fn.sign_define("DapBreakpointRejected", {
    text = "", -- or "❌"
    texthl = "DiagnosticSignError",
    linehl = "",
    numhl = "",
})

vim.fn.sign_define("DapStopped", {
    text = "", -- or "→"
    texthl = "DiagnosticSignWarn",
    linehl = "Visual",
    numhl = "DiagnosticSignWarn",
})

keymaps.set('n', '<leader>db', dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
keymaps.set('n', '<leader>dc', dap.continue, { desc = "Debug: Start/Continue" })
keymaps.set('n', '<leader>do', dap.step_over, { desc = "Debug: Step Over" })
keymaps.set('n', '<leader>di', dap.step_into, { desc = "Debug: Step Into" })
keymaps.set('n', '<leader>dO', dap.step_out, { desc = "Debug: Step Out" })
keymaps.set('n', '<leader>du', dapui.toggle, { desc = "Debug: Toggle UI" })
keymaps.set('n', '<leader>dB', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { desc = "Debug: Conditional Breakpoint" })
keymaps.set('n', '<leader>dq', dap.terminate, { desc = "Debug: Stop" })
keymaps.set('n', '<leader>ddw', vim.diagnostic.open_float, { desc = "Open floating diagnostic window" })
keymaps.set('n', '<leader>ddl', vim.diagnostic.setloclist, { desc = "Diagnostic list" })

-- terminal
require("toggleterm").setup({
    direction = 'horizontal', -- Terminal always horizontal
    size = 60,                -- width in columns
})

keymaps.set('n', '<leader>tv', '<cmd>ToggleTerm direction=vertical size=60<CR>', { desc = "Terminal Vertical Split" })
keymaps.set('n', '<leader>th', '<cmd>ToggleTerm direction=horizontal size=15<CR>', { desc = "Terminal Horizontal Split" })
keymaps.set('t', '<Esc><Esc>', [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- markdown
require("markview").setup({
    initial_state = false,
})


keymaps.set("n", "<leader>mp", "<cmd>Markview splitToggle<CR>", { desc = "Toggle Markdown Preview" })


-- lazygit & lazydocker
keymaps.set('n', '<leader>lg', "<CMD>LazyGit<CR>", { desc = "Run LazyGit" })
keymaps.set('n', '<leader>ld', function() require("lazydocker").open() end, { desc = "Run LazyDocker" })

-- keymap help
local wk = require("which-key")

wk.setup({
    preset = "classic",
    delay = 900,
})

wk.add({
    { '<leader>f', group = '[F]ind', icon = " " },
    { '<leader>l', group = '[L]azy', icon = " " },
    { '<leader>s', group = '[S]plit', icon = "󰤼 " },
    { '<leader>t', group = '[T]erm',  icon = " " },
    { '<leader>jj', hidden = true },
    { '<leader>d', group = '[D]ebug', icon = "" },
})

-- other keymaps
keymaps.set('n', '<leader>ff', ":Pick files<CR>", { desc = "Find files" })
keymaps.set('n', '<leader>fs', ":Pick grep_live<CR>", { desc = "Find string" }) -- Search text in project
keymaps.set('n', '<leader>ee', ":Oil --float<CR>", { desc = "Oil" })


-- programming keymaps
keymaps.set('i', '<S-Tab>', '<C-d>', { desc = "Move indent left in insert mode" })
keymaps.set('v', '<Tab>', '>gv', { desc = "Move selected lines right" })
keymaps.set('v', '<S-Tab>', '<gv', { desc = "Move selected lines left" })

