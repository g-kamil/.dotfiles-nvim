local keymaps = vim.keymap

-- picker
require("mini.pick").setup()

-- sessions
local session = require("mini.sessions")

session.setup({
    autowrite = true,
})

keymaps.set('n', '<leader>Sw', function()
    local name = vim.fn.input('Session name: ')
    if name ~= '' then session.write(name) end
end, { desc = "Save Session" })

keymaps.set('n', '<leader>Sr', function() session.select('read') end, { desc = "Restore Session" })
keymaps.set('n', '<leader>Sd', function() session.select('delete') end, { desc = "Delete Session" })

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
    view_options = { show_hidden = true },
    float = { padding = 8, max_width = 90, max_height = 0 }
})

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
        { mode = 'n', keys = '<Leader>d', desc = '+debug' },
        { mode = 'n', keys = '<Leader>m', desc = '+markdown' },
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

-- other keymaps
keymaps.set('n', '<leader>ff', ":Pick files<CR>", { desc = "Find files" })
keymaps.set('n', '<leader>fs', ":Pick grep_live<CR>", { desc = "Find string" }) -- Search text in project
keymaps.set('n', '<leader>ee', ":Oil --float<CR>", { desc = "Oil" })

