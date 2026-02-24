-- =============== --
-- Basic Settings  --
-- =============== --

require("core.options")
require("core.keymaps")

-- =============== --
--     styling     --
-- =============== --

vim.pack.add({{ src = "https://github.com/neanias/everforest-nvim" },})
vim.cmd("colorscheme everforest")

-- =============== --
-- plugins install --
-- =============== --

vim.pack.add({
        -- editor elements
		{ src = "https://github.com/stevearc/oil.nvim" }, -- for file managing
		{ src = "https://github.com/echasnovski/mini.pick" }, -- for file picking 
		{ src = "https://github.com/mg979/vim-visual-multi" }, -- multicursor; C_down/up; S_arrows; C_N
        { src = "https://github.com/folke/which-key.nvim" }, -- displays keybinding
        { src = "https://github.com/akinsho/toggleterm.nvim" }, -- terminal
        { src = "https://github.com/kdheepak/lazygit.nvim" }, -- for managing git
        { src = "https://github.com/mgierada/lazydocker.nvim" }, -- for managing docker
        { src = "https://github.com/OXY2DEV/markview.nvim" }, -- for makrdown preview
        -- lsp configs
		{ src = "https://github.com/neovim/nvim-lspconfig" },
        { src = "https://github.com/mason-org/mason.nvim" },
        { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
        { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" }, -- for auto tool instalation
        { src = "https://github.com/nvim-treesitter/nvim-treesitter" }, -- Syntax highlighting (AST)
        { src = "https://github.com/hrsh7th/nvim-cmp" },
        { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
        { src = "https://github.com/hrsh7th/cmp-buffer" },
        { src = "https://github.com/hrsh7th/cmp-path" },
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

require("plugins.debugging")
require("plugins.editor")
require("plugins.programming")

