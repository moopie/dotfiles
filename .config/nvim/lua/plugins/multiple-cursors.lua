return {
    "brenton-leighton/multiple-cursors.nvim",
    opts = {},
    keys = {
        { "<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>", mode = { "n", "i", "x" }, desc = "Add cursor up" },
        { "<C-Down>", "<Cmd>MultipleCursorsAddDown<CR>", mode = { "n", "i", "x" }, desc = "Add cursor down" },
        {
            "<C-LeftMouse>",
            "<Cmd>MultipleCursorsMouseAddDelete<CR>",
            mode = { "n", "i" },
            desc = "Add or remove cursor",
        },
        {
            "<C-Return>",
            "<Cmd>MultipleCursorsAddDelete<CR>",
            mode = "n",
            desc = "Add or remove locked cursor",
        },
        {
            "<leader>ma",
            "<Cmd>MultipleCursorsAddMatches<CR>",
            mode = { "n", "x" },
            desc = "Add cursors to matches",
        },
        {
            "<leader>mA",
            "<Cmd>MultipleCursorsAddMatchesV<CR>",
            mode = { "n", "x" },
            desc = "Add cursors to matches in visual area",
        },
        {
            "<leader>md",
            "<Cmd>MultipleCursorsAddJumpNextMatch<CR>",
            mode = { "n", "x" },
            desc = "Add cursor and jump to next match",
        },
        {
            "<leader>mD",
            "<Cmd>MultipleCursorsJumpNextMatch<CR>",
            mode = { "n", "x" },
            desc = "Jump to next match",
        },
        {
            "<leader>ml",
            "<Cmd>MultipleCursorsLockToggle<CR>",
            mode = { "n", "x" },
            desc = "Toggle locked cursors",
        },
        {
            "<leader>mv",
            "<Cmd>MultipleCursorsAddVisualArea<CR>",
            mode = "x",
            desc = "Add cursors to visual lines",
        },
    },
}
