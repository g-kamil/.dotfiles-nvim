local keymaps = vim.keymap

local dap = require("dap")
local dapui = require("dapui")

require("dap-python").setup(vim.fn.exepath("debugpy-adapter"))
require("nvim-dap-virtual-text").setup()

dapui.setup({
    layouts = {
        {
            elements = {
                { id = "console", size = 1 },
            },
            position = "bottom",
            size = 10,
        },
        {
            elements = {
                { id = "repl", size = 0.05 },
                { id = "breakpoints", size = 0.25 },
                { id = "stacks", size = 0.35 },
                { id = "watches", size = 0.35 },
            },
            position = "right",
            size = 40,
        },
    },
})

vim.fn.sign_define("DapBreakpoint", {
    text = "",
    texthl = "DiagnosticSignError",
    linehl = "",
    numhl = "",
})

vim.fn.sign_define("DapBreakpointRejected", {
    text = "",
    texthl = "DiagnosticSignError",
    linehl = "",
    numhl = "",
})

vim.fn.sign_define("DapStopped", {
    text = "", -- or "→"
    texthl = "DiagnosticSignWarn",
    linehl = "Visual",
    numhl = "DiagnosticSignWarn",
})

keymaps.set('n', '<leader>db', dap.toggle_breakpoint, { desc = " Toggle Breakpoint" })
keymaps.set('n', '<leader>dB', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { desc = " Conditional Breakpoint" })
keymaps.set('n', '<leader>dc', dap.continue, { desc = " Start/Continue" })
keymaps.set('n', '<leader>do', dap.step_over, { desc = " Step Over" })
keymaps.set('n', '<leader>di', dap.step_into, { desc = " Step Into" })
keymaps.set('n', '<leader>dO', dap.step_out, { desc = " Step Out" })
keymaps.set('n', '<leader>du', dapui.toggle, { desc = "Toggle dapUI" })
keymaps.set('n', '<leader>dq', dap.terminate, { desc = " Stop" })
keymaps.set('n', '<leader>dw', vim.diagnostic.open_float, { desc = "Open floating diagnostic window" })
keymaps.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = "Diagnostic list" })
