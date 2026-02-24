local keymaps = vim.keymap

require("mini.pick").setup()

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

