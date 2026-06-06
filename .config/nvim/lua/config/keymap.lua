vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open dir in oil" })
vim.keymap.set("n", "<leader>w", "<cmd>write<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", "<cmd>quit<CR>", { desc = "Quit window" })
vim.keymap.set("n", "<leader>qq", "<cmd>qa<CR>", { desc = "Quit all" })
vim.keymap.set("n", "<leader>e", "<cmd>Oil<CR>", { desc = "Open file explorer" })
vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "Disable search highlight" })
vim.keymap.set("n", "<leader><space>", function()
    require("telescope.builtin").find_files({ cwd = vim.fn.getcwd() })
end, { desc = "Telescope current dir" })
vim.keymap.set("n", "<leader>/", function()
    require("telescope.builtin").live_grep()
end, { desc = "Grep in project" })
vim.keymap.set("n", "<leader>,", function()
    require("telescope.builtin").buffers()
end, { desc = "Switch buffer" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
vim.keymap.set("n", "<X1Mouse>", "<C-o>", { desc = "Jump back" })
vim.keymap.set("n", "<X2Mouse>", "<C-i>", { desc = "Jump forward" })

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
local function telescope_lsp(picker, opts)
    return function()
        require("telescope.builtin")[picker](opts)
    end
end

vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>k", vim.diagnostic.open_float)
vim.keymap.set("n", "gd", telescope_lsp("lsp_definitions"), { desc = "LSP definitions" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gi", telescope_lsp("lsp_implementations"), { desc = "LSP implementations" })
vim.keymap.set("n", "go", telescope_lsp("lsp_type_definitions"), { desc = "LSP type definitions" })
vim.keymap.set("n", "gr", telescope_lsp("lsp_references"), { desc = "LSP references" })
vim.keymap.set("n", "gs", vim.lsp.buf.signature_help)
vim.keymap.set("n", "<F2>", vim.lsp.buf.rename)
vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>lq", telescope_lsp("diagnostics"), { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>ll", telescope_lsp("diagnostics", { bufnr = 0 }), { desc = "Buffer diagnostics" })

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
