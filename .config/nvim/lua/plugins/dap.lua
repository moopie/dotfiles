return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"mfussenegger/nvim-dap-python",
			"nvim-neotest/nvim-nio",
			"mason-org/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",
		},

		keys = {
			{
				"<F5>",
				function()
					require("dap").continue()
				end,
				desc = "Debug: Start/Continue",
			},
			{
				"<F10>",
				function()
					require("dap").step_over()
				end,
				desc = "Debug: Step Over",
			},
			{
				"<F11>",
				function()
					require("dap").step_into()
				end,
				desc = "Debug: Step Into",
			},
			{
				"<F12>",
				function()
					require("dap").step_out()
				end,
				desc = "Debug: Step Out",
			},
			{
				"<leader>b",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Debug: Toggle Breakpoint",
			},
			{
				"<leader>dr",
				function()
					require("dap").repl.open()
				end,
				desc = "Debug: Open REPL",
			},
			{
				"<leader>dl",
				function()
					require("dap").run_last()
				end,
				desc = "Debug: Run Last",
			},
			{
				"<leader>du",
				function()
					require("dapui").toggle()
				end,
				desc = "Debug: Toggle UI",
			},
		},

		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- Mason DAP automatic setup
			require("mason-nvim-dap").setup({
				ensure_installed = { "delve", "debugpy", "codelldb", "coreclr" },
				automatic_installation = true,
				automatic_setup = true,
			})

			-- Allow mason-nvim-dap to set up handlers AFTER we define our custom ones
			--require("mason-nvim-dap").setup_handlers({})

			-- UI
			dapui.setup()
			require("nvim-dap-virtual-text").setup()

			vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
			vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticWarn" })

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- CUSTOM: Go (manual Delve spawn)
			-- Overrides mason default
			dap.adapters.go = function(callback, _)
				local port = 38697
				local handle
				handle = vim.loop.spawn("dlv", {
					args = { "dap", "-l", "127.0.0.1:" .. port },
					detached = true,
				}, function(code)
					handle:close()
					print("Delve exited with code", code)
				end)

				-- Wait a bit for Delve to start
				vim.defer_fn(function()
					callback({ type = "server", host = "127.0.0.1", port = port })
				end, 100)
			end

			dap.configurations.go = {
				{
					type = "go",
					name = "Debug",
					request = "launch",
					program = "${file}",
				},
			}

			-- CUSTOM: C# (netcoredbg)
			-- mason installs but we override config because of your input prompt
			dap.adapters.coreclr = {
				type = "executable",
				command = vim.fn.expand("~/.local/share/nvim/mason/bin/netcoredbg"),
				args = { "--interpreter=vscode" },
			}

			dap.configurations.cs = {
				{
					type = "coreclr",
					name = "Launch .NET",
					request = "launch",
					program = function()
						return vim.fn.input("Path to DLL: ", vim.fn.getcwd() .. "/bin/Debug/net8.0/", "file")
					end,
				},
			}

			-- Python – let mason handle debugpy
			-- BUT we still hook python3 for convenience
			require("dap-python").setup("python3")

			-- CUSTOM: Rust (codelldb) with prompt
			local codelldb_path =
				vim.fn.expand("~/.local/share/nvim/mason/packages/codelldb/extension/adapter/codelldb")

			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = codelldb_path,
					args = { "--port", "${port}" },
				},
			}

			dap.configurations.rust = {
				{
					name = "Debug",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
					end,
					cwd = "${workspaceFolder}",
				},
			}
		end,
	},
}
