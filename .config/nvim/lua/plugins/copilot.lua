return {
  'zbirenbaum/copilot.lua',
  cmd = "Copilot",
  build = ":Copilot auth",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<Tab>",
          next = "<C-j>",
          prev = "<C-k>",
          dismiss = "<C-\\>",
        },
      },
      filetypes = {
        markdown = true,
        help = true,
      },
      panel = {
        enabled = true,
        auto_refresh = true,
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<CR>",
          refresh = "gr",
          open = "<C-CR>",
          close = "<C-\\>",
        },
      },
    })
  end,
}
