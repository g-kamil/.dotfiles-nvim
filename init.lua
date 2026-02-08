-- opt(ions)
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

-- map leader key
vim.g.mapleader = " "

vim.keymap.set('n', 'q', '<Nop>', { noremap = true, silent = true }) -- unmap q as it's fucking annoying

-- standard keymaps
vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>', { desc = "Update and Source current buffer" })
vim.keymap.set('n', '<leader>w', ':write<CR>', { desc = "Save buffer" })
vim.keymap.set('n', '<leader>qq', ':wq<CR>', { desc = "Save&Quit" })
vim.keymap.set('n', '<Tab>', ':tabnext<CR>', { desc = "Next tab" })
vim.keymap.set('n', '<S-Tab>', ':tabprevious<CR>' , { desc = "Prev tab" })


-- system clipboard
vim.keymap.set({'n', 'v', 'x'}, '<leader>y', '"+y<CR>', { desc = "yank to system clipboard" })
vim.keymap.set({'n', 'v', 'x'}, '<leader>d', '"+d<CR>', { desc = "delete to system clipboard" })
vim.keymap.set({'n', 'v' }, '<leader>p', '"+p<CR>', { desc = "paste from system clipboard" })


-- package install
vim.pack.add({
		{ src = "https://github.com/stevearc/oil.nvim" }, -- file manager
		{ src = "https://github.com/echasnovski/mini.pick" }, -- file picker
		{ src = "https://github.com/neovim/nvim-lspconfig" },
        { src = "https://github.com/mason-org/mason.nvim" }, -- lsp management
        { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
		{ src = "https://github.com/neanias/everforest-nvim" }, -- style
		{ src = "https://github.com/mg979/vim-visual-multi" }, -- multicursor; C_down/up; S_arrows; C_N
        { src = "https://github.com/kdheepak/lazygit.nvim" }, -- lazygit
        { src = "https://github.com/mgierada/lazydocker.nvim" }, -- lazydocker
            -- { src = "https://github.com/akinsho/toggleterm.nvim" }, -- required by lazydocker; autoinstall
})

-- package setup
require("mini.pick").setup()
require("oil").setup()
require("mason").setup()
require("mason-lspconfig").setup()
require("lazydocker").setup()

-- package keymaps
vim.keymap.set('n', '<leader>f', ":Pick files<CR>", { desc = "Picker files" })
vim.keymap.set('n', '<leader>e', ":Oil --float<CR>", { desc = "Oil float" })
vim.keymap.set('n', '<leader>lg', "<CMD>LazyGit<CR>", { desc = "Run LazyGit" })
vim.keymap.set('n', '<leader>ld', function() require("lazydocker").open() end, { desc = "Run LazyDocker" })

-- appearance
vim.cmd("colorscheme everforest")
vim.o.laststatus = 3 -- Global statusline (one for all windows)

-- programming setup
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = "Open floating diagnostic window" })
vim.keymap.set('n', '<leader>qf', vim.diagnostic.setloclist, { desc = "Diagnostic list" })
