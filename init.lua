-- =============== --
-- Basic Settings  --
-- =============== --
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes" -- adds column on left for "signals"
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4 -- 4 spaces when tab
vim.o.expandtab = true -- change tab to spaces
vim.o.smartindent = true -- automatic indentation
vim.o.ignorecase = true -- ignore case when searching
vim.o.smartcase = true -- extends above (if you write UpperCase)
vim.o.cursorline = true -- highlight line with cursor
vim.o.swapfile = false
vim.o.winborder = "rounded"
vim.o.laststatus = 3 -- global statusline for all windows
vim.o.termguicolors = true -- for some 'coloring' plugins
vim.o.scrolloff = 8 -- Keep 8 lines visible when scrolling
vim.o.updatetime = 250 -- Faster update time for CursorHold events

-- map leader key
vim.g.mapleader = " "
vim.keymap.set('n', 'q', '<Nop>', { noremap = true, silent = true }) -- unmap q as it's fucking annoying
vim.keymap.set('n', 's', '<Nop>', { noremap = true, silent = true }) -- unmap s so it's not insert mode

-- standard keymaps
vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>', { desc = "Update and Source current buffer" })
vim.keymap.set('n', '<leader>w', ':write<CR>', { desc = "Save buffer" })
vim.keymap.set('n', '<leader>qq', ':quit<CR>', { desc = "Quit" })
vim.keymap.set('n', '<leader>jj', ':wq<CR>', { desc = "Write&Quit" })
vim.keymap.set('n', '<Tab>', ':tabnext<CR>', { desc = "Next tab" })
vim.keymap.set('n', '<S-Tab>', ':tabprevious<CR>' , { desc = "Prev tab" })
vim.keymap.set('n', '<leader>sh', ':split<CR>', { desc = "Split Horizontal" })
vim.keymap.set('n', '<leader>sv', ':vsplit<CR>', { desc = "Split Vertical" })
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = "Go to Left Window" })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = "Go to Lower Window" })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = "Go to Upper Window" })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = "Go to Right Window" })
vim.keymap.set('n', '<M-Up>', ':resize -2<CR>' ,{ desc = "Resize window 2px up"})
vim.keymap.set('n', '<M-Down>', ':resize +2<CR>', { desc = "Resize window 2px down"})
vim.keymap.set('n', '<M-Left>', ':vertical resize -2<CR>', { desc = "Resize window 2px left"})
vim.keymap.set('n', '<M-Right>', ':vertical resize +2<CR>', { desc = "Resize window 2px right"})

-- system clipboard
vim.keymap.set({'n', 'v', 'x'}, '<leader>y', '"+y<CR>', { desc = "yank to system clipboard" })
vim.keymap.set({'n', 'v', 'x'}, '<leader>d', '"+d<CR>', { desc = "delete to system clipboard" })
vim.keymap.set({'n', 'v' }, '<leader>p', '"+p<CR>', { desc = "paste from system clipboard" })

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
        -- lsp
		{ src = "https://github.com/neovim/nvim-lspconfig" },
        { src = "https://github.com/mason-org/mason.nvim" },
        { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
        -- autocompletion
        { src = "https://github.com/hrsh7th/nvim-cmp" },     -- The engine
        { src = "https://github.com/hrsh7th/cmp-nvim-lsp" }, -- LSP source for cmp
        { src = "https://github.com/hrsh7th/cmp-buffer" },   -- Buffer source
        { src = "https://github.com/hrsh7th/cmp-path" },     -- Path source
        -- terminal
        { src = "https://github.com/akinsho/toggleterm.nvim" },
        { src = "https://github.com/kdheepak/lazygit.nvim" },
        { src = "https://github.com/mgierada/lazydocker.nvim" },
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
    ensure_installed = { "python", "lua", "vim", "vimdoc", "bash", "go", "dockerfile", "json", "yaml" },
    highlight = { enable = true },
    indent = { enable = true },
})

-- completion
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "ty", "gopls", "bashls", "lua_ls" },
})

-- terminal
require("toggleterm").setup({
    direction = 'horizontal', -- Terminal always horizontal
    size = 60,                -- width in columns
})

vim.keymap.set('n', '<leader>tv', '<cmd>ToggleTerm direction=vertical size=60<CR>', { desc = "Terminal Vertical Split" })
vim.keymap.set('n', '<leader>th', '<cmd>ToggleTerm direction=horizontal size=15<CR>', { desc = "Terminal Horizontal Split" })

-- lazygit & lazydocker
vim.keymap.set('n', '<leader>lg', "<CMD>LazyGit<CR>", { desc = "Run LazyGit" })
vim.keymap.set('n', '<leader>ld', function() require("lazydocker").open() end, { desc = "Run LazyDocker" })

-- other keymaps
vim.keymap.set('n', '<leader>ff', ":Pick files<CR>", { desc = "Find files" })
vim.keymap.set('n', '<leader>fs', ":Pick grep_live<CR>", { desc = "Find string" }) -- Search text in project
vim.keymap.set('n', '<leader>e', ":Oil --float<CR>", { desc = "Oil float" })


-- programming keymaps
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = "Open floating diagnostic window" })
vim.keymap.set('n', '<leader>qf', vim.diagnostic.setloclist, { desc = "Diagnostic list" })
vim.keymap.set('i', '<S-Tab>', '<C-d>', { desc = "Move indent left in insert mode" })
vim.keymap.set('v', '<Tab>', '>gv', { desc = "Move selected lines right" })
vim.keymap.set('v', '<S-Tab>', '<gv', { desc = "Move selected lines left" })

