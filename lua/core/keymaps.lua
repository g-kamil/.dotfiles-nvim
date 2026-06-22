local set = vim.keymap.set

set('n', 'q', '<Nop>', { noremap = true, silent = true }) -- unmap q as it's fucking annoying
set('n', 's', '<Nop>', { noremap = true, silent = true }) -- unmap s so it's not insert mode

-- standard keymaps
-- set('n', '<leader>o', ':update<CR> :source<CR>', { desc = "Update and Source current buffer" })
set('n', '<leader>w', ':write<CR>', { desc = "Save buffer" })
set('n', '<leader>qq', ':quit!<CR>', { desc = "Quit" })
set('n', '<leader>jj', ':wq<CR>', { desc = "Write&Quit" })
set('n', '<Tab>', ':tabnext<CR>', { desc = "Next tab" })
set('n', '<S-Tab>', ':tabprevious<CR>' , { desc = "Prev tab" })
set('n', '<leader>sh', ':split<CR>', { desc = "Split Horizontal" })
set('n', '<leader>sv', ':vsplit<CR>', { desc = "Split Vertical" })
set('n', '<M-Up>', ':resize -2<CR>' ,{ desc = "Resize window 2px up"})
set('n', '<M-Down>', ':resize +2<CR>', { desc = "Resize window 2px down"})
set('n', '<M-Left>', ':vertical resize -2<CR>', { desc = "Resize window 2px left"})
set('n', '<M-Right>', ':vertical resize +2<CR>', { desc = "Resize window 2px right"})

-- system clipboard
set({'n', 'v', 'x'}, '<leader>y', '"+y<CR>', { desc = "yank to system clipboard" })
set({'n', 'v', 'x'}, '<leader>d', '"+d<CR>', { desc = "delete to system clipboard" })
set({'n', 'v' }, '<leader>p', '"+p<CR>', { desc = "paste from system clipboard" })

-- programming keymaps
set('i', '<S-Tab>', '<C-d>', { desc = "Move indent left in insert mode" })
set('v', '<Tab>', '>gv', { desc = "Move selected lines right" })
set('v', '<S-Tab>', '<gv', { desc = "Move selected lines left" })
