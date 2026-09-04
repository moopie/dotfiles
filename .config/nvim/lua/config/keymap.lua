vim.keymap.set("n", "-", "<cmd>Yazi<CR>", { desc = "Open yazi at current file" })
vim.keymap.set("n", "<leader>w", "<cmd>write<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", "<cmd>quit<CR>", { desc = "Quit window" })
vim.keymap.set("n", "<leader>qq", "<cmd>qa<CR>", { desc = "Quit all" })
vim.keymap.set("n", "<leader>e", "<cmd>Yazi cwd<CR>", { desc = "Open file explorer" })
vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "Disable search highlight" })
vim.keymap.set("n", "<leader><space>", function()
    require("fzf-lua").files({ cwd = vim.fn.getcwd() })
end, { desc = "Find files in current dir" })
vim.keymap.set("n", "<leader>/", function()
    require("fzf-lua").live_grep()
end, { desc = "Grep in project" })
vim.keymap.set("n", "<leader>,", function()
    require("fzf-lua").buffers()
end, { desc = "Switch buffer" })

vim.keymap.set("n", "<X1Mouse>", "<C-o>", { desc = "Jump back" })
vim.keymap.set("n", "<X2Mouse>", "<C-i>", { desc = "Jump forward" })

vim.keymap.set("n", "<leader>ff", function()
    require("fzf-lua").files()
end, { desc = "Find files" })

vim.keymap.set("n", "<leader>fg", function()
    require("fzf-lua").live_grep()
end, { desc = "Live grep" })

vim.keymap.set("n", "<leader>fb", function()
    require("fzf-lua").buffers()
end, { desc = "Buffers" })

vim.keymap.set("n", "<leader>fh", function()
    require("fzf-lua").help_tags()
end, { desc = "Help tags" })

-- LSP
local function fzf_lsp(picker, opts)
    return function()
        require("fzf-lua")[picker](opts)
    end
end

vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>k", vim.diagnostic.open_float)
vim.keymap.set("n", "gd", fzf_lsp("lsp_definitions"), { desc = "LSP definitions" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gi", fzf_lsp("lsp_implementations"), { desc = "LSP implementations" })
vim.keymap.set("n", "go", fzf_lsp("lsp_typedefs"), { desc = "LSP type definitions" })
vim.keymap.set("n", "gr", fzf_lsp("lsp_references"), { desc = "LSP references" })
vim.keymap.set("n", "gs", vim.lsp.buf.signature_help)
vim.keymap.set("n", "<F2>", vim.lsp.buf.rename)
vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>lq", fzf_lsp("diagnostics_workspace"), { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>ll", fzf_lsp("diagnostics_document"), { desc = "Buffer diagnostics" })

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
