-- picker
require("mini.pick").setup()
require("mini.extra").setup()

-- mini utils
require("mini.pairs").setup()
require("mini.surround").setup()
require("mini.statusline").setup()

-- noice.nvim
require("noice").setup({
    lsp = {
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
        },
    },
    presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
    },
})

-- keymaps
vim.keymap.set('n', '<leader>fk', '<cmd>Pick keymaps<Enter>', { desc = 'Find Keymap'})
vim.keymap.set('n', '<leader>fc', '<cmd>Pick commands<Enter>', { desc = 'Find Command'})

-- sessions
local session = require("mini.sessions")

session.setup({
    autowrite = true,
})

vim.keymap.set('n', '<leader>Sw', function()
    local name = vim.fn.input('Session name: ')
    if name ~= '' then session.write(name) end
end, { desc = "Save Session" })

vim.keymap.set('n', '<leader>Sr', function() session.select('read') end, { desc = "Restore Session" })
vim.keymap.set('n', '<leader>Sd', function() session.select('delete') end, { desc = "Delete Session" })

-- dashboard
local starter = require('mini.starter')

local header = table.concat({
"⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣤⣶⣶⣶⣶⣶⣤⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ",
"⠀⠀⠀⠀⠀⠀⣠⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣄⡀⠀⠀⠀⠀⠀",
"⠀⠀⠀⣠⣴⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣮⣵⣄⠀⠀⠀ Oh, hey!",
"⠀⠀⢾⣻⣿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⣿⡀⠀",
"⠀⠸⣽⣻⠃⣿⡿⠋⣉⠛⣿⣿⣿⣿⣿⣿⣿⣿⣏⡟⠉⡉⢻⣿⡌⣿⣳⡥⠀",
"⠀⢜⣳⡟⢸⣿⣷⣄⣠⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣤⣠⣼⣿⣇⢸⢧⢣⠀",
"⠀⠨⢳⠇⣸⣿⣿⢿⣿⣿⣿⣿⡿⠿⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⠀⡟⢆⠀",
"⠀⠀⠈⠀⣾⣿⣿⣼⣿⣿⣿⣿⡀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣽⣿⣿⠐⠈⠀⠀",
"⠀⢀⣀⣼⣷⣭⣛⣯⡝⠿⢿⣛⣋⣤⣤⣀⣉⣛⣻⡿⢟⣵⣟⣯⣶⣿⣄⡀⠀",
"⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣶⣶⣾⣶⣶⣴⣾⣿⣿⣿⣿⣿⣿⢿⣿⣿⣧",
"⣿⣿⣿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⣿⡿",
}, '\n')

local docker_starter = function()
    local ld = require("lazydocker")
    ld.open()
end

starter.setup({
    items = {
        { name = 'Find Files',  action = 'Pick files',     section = 'Actions' },
        { name = 'Find String', action = 'Pick grep_live', section = 'Actions' },
        { name = 'File Browser',action = 'Oil --float',    section = 'Actions' },
        { name = 'LazyGit',     action = 'LazyGit',        section = 'Actions' },
        { name = 'LazyDocker',  action = docker_starter,   section = 'Actions' },
        { name = 'New File',    action = 'enew',           section = 'Actions' },
        starter.sections.recent_files(5, false),
        starter.sections.sessions(5, true),
    },
    header = header,
    content_hooks = {
        starter.gen_hook.adding_bullet('  ', false),
        starter.gen_hook.indexing('all', { 'Recent files', 'Sessions' }),
        starter.gen_hook.aligning('center', 'center'),
    },
})

-- file explorer
require("oil").setup({
    columns = {"icon"},
    view_options = { show_hidden = true },
    float = { padding = 8, max_width = 90, max_height = 0 }
})

-- terminal
require("toggleterm").setup({
    open_mapping = [[<c-\>]], -- open mapping
    direction = 'float', -- Terminal always floating
})

vim.keymap.set('n', '<leader>tv', '<cmd>ToggleTerm direction=vertical size=60<Enter>', { desc = "Terminal Vertical Split" })
vim.keymap.set('n', '<leader>th', '<cmd>ToggleTerm direction=horizontal size=15<Enter>', { desc = "Terminal Horizontal Split" })
vim.keymap.set('t', '<Esc><Esc>', [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- markdown (lazy: loaded on first markdown file)
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'markdown',
    once = true,
    callback = function()
        require("markview").setup({ initial_state = false })
    end,
})

vim.keymap.set("n", "<leader>mp", ":Markview splitToggle<Enter>", { desc = "Toggle Markdown Preview" })

-- lazygit & lazydocker
vim.keymap.set('n', '<leader>lg', ":LazyGit<Enter>", { desc = "Run LazyGit" })
vim.keymap.set('n', '<leader>ld', function() require("lazydocker").open() end, { desc = "Run LazyDocker" })

-- keybinding hints
local miniclue = require('mini.clue')

miniclue.setup({
    triggers = {
        { mode = 'n', keys = '<Leader>' },
        { mode = 'n', keys = '<C-w>' },
        { mode = 'n', keys = "'" },
        { mode = 'n', keys = '`' },
        { mode = 'n', keys = 'g' },
        { mode = 'n', keys = '"' },
        { mode = 'n', keys = 'z' },
        { mode = 'x', keys = '<Leader>' },
        { mode = 'x', keys = 'g' },
        { mode = 'x', keys = "'" },
        { mode = 'x', keys = '`' },
        { mode = 'x', keys = '"' },
        { mode = 'x', keys = 'z' },
        { mode = 'i', keys = '<C-r>' },
        { mode = 'i', keys = '<C-x>' },
        { mode = 'c', keys = '<C-r>' },
    },

    clues = {
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),

        { mode = 'n', keys = '<Leader>f', desc = '+find' },
        { mode = 'n', keys = '<Leader>l', desc = '+lazy' },
        { mode = 'n', keys = '<Leader>s', desc = '+split' },
        { mode = 'n', keys = '<Leader>S', desc = '+sessions' },
        { mode = 'n', keys = '<Leader>t', desc = '+term' },
        { mode = 'n', keys = '<Leader>d', desc = '+debug/diag' },
        { mode = 'n', keys = '<Leader>m', desc = '+markdown' },
        { mode = 'n', keys = '<Leader>o', desc = '+opencode' },
    },

    window = {
        delay = 600,
        config = {
            width = 'auto',
            border = 'rounded',
            anchor = 'SW',
            row = 'auto',
            col = 'auto',
        },
    },
})

-- gitsigns
require("gitsigns").setup({
    signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "-" },
        changedelete = { text = "~" },
    }
})

-- vim-tmux-navigator
vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<Enter>")
vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<Enter>")
vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<Enter>")
vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<Enter>")

-- other keymaps
vim.keymap.set('n', '<leader>ff', "<cmd>Pick files<Enter>", { desc = "Find Files" })
vim.keymap.set('n', '<leader>fs', "<cmd>Pick grep_live<Enter>", { desc = "Find String" }) -- Search text in project
vim.keymap.set('n', '<leader>ee', "<cmd>Oil --float<Enter>", { desc = "Oil" })


