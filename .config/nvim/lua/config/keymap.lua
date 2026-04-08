vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open dir in oil" })
vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "Disable search highlight" })

vim.keymap.set("n", "<leader>ff", function()
    require("telescope.builtin").find_files()
end, { desc = "Telescope find files" })

vim.keymap.set("n", "<leader>fg", function()
    require("telescope.builtin").live_grep()
end, { desc = "Telescope live grep" })

vim.keymap.set("n", "<leader>fb", function()
    require("telescope.builtin").buffers()
end, { desc = "Telescope buffers" })

vim.keymap.set("n", "<leader>fh", function()
    require("telescope.builtin").help_tags()
end, { desc = "Telescope help tags" })

-- LSP
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>k", vim.diagnostic.open_float)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
vim.keymap.set("n", "go", vim.lsp.buf.type_definition)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "gs", vim.lsp.buf.signature_help)
vim.keymap.set("n", "<F2>", vim.lsp.buf.rename)
vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>lq", function()
    local win = vim.api.nvim_get_current_win()
    vim.diagnostic.setqflist({ open = true })
    vim.api.nvim_set_current_win(win)
end, { desc = "Diagnostics → Quickfix" })
vim.keymap.set("n", "<leader>ll", function()
    local win = vim.api.nvim_get_current_win()
    vim.diagnostic.setloclist({ open = true })
    vim.api.nvim_set_current_win(win)
end, { desc = "Diagnostics → Loclist" })

local watching = false

-- neotest
vim.keymap.set("n", "<leader>tw", function()
    if watching then
        require("neotest").watch.stop()
        watching = false
        print("Neotest auto-watch stopped")
    else
        require("neotest").watch.watch()
        watching = true
        print("Neotest auto-watch started")
    end
end)

vim.keymap.set("n", "<leader>ts", function()
    require("neotest").summary.toggle()
end)

vim.keymap.set("n", "<leader>to", function()
    require("neotest").output()
end)
