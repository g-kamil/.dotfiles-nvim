
local options = vim.o

options.number = true
options.relativenumber = true
options.signcolumn = "yes" -- adds column on left for "signals"
options.wrap = false
options.tabstop = 4
options.shiftwidth = 4 -- 4 spaces when tab
options.expandtab = true -- change tab to spaces
options.smartindent = true -- automatic indentation
options.ignorecase = true -- ignore case when searching
options.smartcase = true -- extends above (if you write UpperCase)
options.cursorline = true -- highlight line with cursor
options.swapfile = false
options.winborder = "rounded"
options.laststatus = 3 -- global statusline for all windows
options.termguicolors = true -- for some 'coloring' plugins
options.scrolloff = 8 -- Keep 8 lines visible when scrolling
options.updatetime = 250 -- Faster update time for CursorHold events



vim.g.mapleader = " "
