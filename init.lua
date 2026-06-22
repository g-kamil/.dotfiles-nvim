-- =============== --
-- Basic Settings  --
-- =============== --
require("core.options")
require("core.keymaps")

-- =============== --
--   colorscheme   --
-- =============== --
vim.pack.add({{ src = "https://github.com/neanias/everforest-nvim" },})
vim.cmd("colorscheme everforest")

-- =============== --
-- plugins install --
-- =============== --
local gh = function(x) return 'https://github.com/' .. x end

vim.pack.add({
        -- dependencies for other packages
        { src = gh("nvim-lua/plenary.nvim")},
        { src = gh("MunifTanjim/nui.nvim") }, -- dependency for noice.nvim
        { src = gh("rcarriga/nvim-notify") }, -- dependency for noice.nvim & nice notification system
        { src = gh("stevearc/dressing.nvim") },
        { src = gh("folke/snacks.nvim") },
        -- editor elements
		{ src = gh("nvim-mini/mini.nvim") }, -- set of standard utils for nvim, like picker, statusbar etc.
		{ src = gh("stevearc/oil.nvim") }, -- file management and explorer
        { src = gh("akinsho/toggleterm.nvim") }, -- persist and toggle multiple terminals
        { src = gh("kdheepak/lazygit.nvim") }, -- for managing git
        { src = gh("mgierada/lazydocker.nvim") }, -- for managing docker
        { src = gh("OXY2DEV/markview.nvim") }, -- for markdown preview
        { src = gh("christoomey/vim-tmux-navigator") }, -- vim-tmux keybind integration
        { src = gh("folke/noice.nvim") }, -- floating command window
        { src = gh("lewis6991/gitsigns.nvim") }, -- git info inline
        -- lsp configs
		{ src = gh("neovim/nvim-lspconfig") }, -- standard lspconfig
        { src = gh("mason-org/mason.nvim") }, -- for managing lsp plugins
        { src = gh("mason-org/mason-lspconfig.nvim") }, -- auto run mason installed plugins
        { src = gh("WhoIsSethDaniel/mason-tool-installer.nvim") }, -- auto instalation tools
        { src = gh("nvim-treesitter/nvim-treesitter"), version = 'main' }, -- Syntax highlighting (AST)
        { src = gh("saghen/blink.cmp")}, -- code complition manager
        { src = gh("L3MON4D3/LuaSnip")},
        { src = gh("rafamadriz/friendly-snippets")},
})

-- ============== --
-- plugin cleanup --
-- ============== --
vim.api.nvim_create_user_command('PackClean', function()
    local active_plugins = {}
    local unused_plugins = {}

    for _, plugin in ipairs(vim.pack.get()) do
        active_plugins[plugin.spec.name] = plugin.active
    end

    for _, plugin in ipairs(vim.pack.get()) do
        if not active_plugins[plugin.spec.name] then
            table.insert(unused_plugins, plugin.spec.name)
        end
    end

    if #unused_plugins == 0 then
        print("No unused plugins.")
        return
    end

    local choice = vim.fn.confirm("Remove unused plugins?", "&Yes\n&No", 2)
    if choice == 1 then
        vim.pack.del(unused_plugins)
    end
end, { desc = "Clean unused packages"})

-- ============= --
-- plugin setup  --
-- ============= --
require("plugins.editor")
require("plugins.programming")
