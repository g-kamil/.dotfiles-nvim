
local keymaps = vim.keymap

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


-- programming keymaps
keymaps.set('i', '<S-Tab>', '<C-d>', { desc = "Move indent left in insert mode" })
keymaps.set('v', '<Tab>', '>gv', { desc = "Move selected lines right" })
keymaps.set('v', '<S-Tab>', '<gv', { desc = "Move selected lines left" })
