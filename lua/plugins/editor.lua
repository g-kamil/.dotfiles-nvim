local keymaps = vim.keymap

require("mini.pick").setup()

-- sessions
require("mini.sessions").setup({
    autowrite = true,
})

keymaps.set('n', '<leader>Sw', function()
    local name = vim.fn.input('Session name: ')
    if name ~= '' then require('mini.sessions').write(name) end
end, { desc = "Save Session" })

keymaps.set('n', '<leader>Sr', function()
    require('mini.sessions').select('read')
end, { desc = "Restore Session" })

keymaps.set('n', '<leader>Sd', function()
    require('mini.sessions').select('delete')
end, { desc = "Delete Session" })

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

-- keymap help
local wk = require("which-key")

wk.setup({
    preset = "classic",
    delay = 900,
})

wk.add({
    { '<leader>f', group = '[F]ind', icon = " " },
    { '<leader>l', group = '[L]azy', icon = " " },
    { '<leader>s', group = '[s]plit', icon = "󰤼 " },
    { '<leader>S', group = '[S]essions', icon = " " },
    { '<leader>t', group = '[T]erm',  icon = " " },
    { '<leader>d', group = '[D]ebug', icon = "" },
    { '<leader>jj', hidden = true },
})

-- other keymaps
keymaps.set('n', '<leader>ff', ":Pick files<CR>", { desc = "Find files" })
keymaps.set('n', '<leader>fs', ":Pick grep_live<CR>", { desc = "Find string" }) -- Search text in project
keymaps.set('n', '<leader>ee', ":Oil --float<CR>", { desc = "Oil" })

