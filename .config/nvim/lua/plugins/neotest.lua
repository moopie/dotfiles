return {
    "nvim-neotest/neotest",
    lazy = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-neotest/nvim-nio",
        "antoinemadec/FixCursorHold.nvim",

        -- Adapters
        "nvim-neotest/neotest-python",
        "nvim-neotest/neotest-go",
        "rouge8/neotest-rust",
        "Issafalcon/neotest-dotnet",
    },

    config = function()
        vim.cmd.packadd("nvim-nio")

        local neotest = require("neotest")

        neotest.setup({
            discovery = { enabled = true },

            adapters = {
                -- Python
                require("neotest-python")({
                    -- Uses the Python debug adapter you already installed via mason-nvim-dap
                    dap = { justMyCode = false },
                    runner = "pytest",
                }),

                -- Go
                require("neotest-go")({
                    experimental = { test_table = true },
                }),

                -- Rust
                require("neotest-rust")({
                    args = { "--nocapture" },
                    dap_adapter = "codelldb", -- mason-nvim-dap installs this
                }),

                -- C# / .NET
                require("neotest-dotnet")({
                    dap = { justMyCode = false }, -- uses netcoredbg from mason-nvim-dap
                    discovery_root = "project", -- auto-detect *.csproj or *.sln
                }),
            },
        })

        -- Create a user command for watching
        vim.api.nvim_create_user_command("NeotestWatch", function()
            neotest.watch.watch()
        end, {})

        vim.api.nvim_create_user_command("NeotestWatchStop", function()
            neotest.watch.stop()
        end, {})
    end,
}
