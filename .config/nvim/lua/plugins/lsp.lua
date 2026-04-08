return {
	"neovim/nvim-lspconfig",

	opts = function(_, opts)
		opts.servers = opts.servers or {}

		-- enable inlay hints globally
		opts.inlay_hints = opts.inlay_hints or { enabled = true }

		local my_servers = {
			-- Go
			gopls = {
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
							shadow = true,
						},
						staticcheck = true,
					},
				},
			},

			-- C# - use global csharp-ls, NOT mason
			csharp_ls = {
				mason = false, -- <── important: tells LazyVim/mason-lspconfig to leave it alone
				-- you can add extra settings here later if needed
			},

			-- Rust
			rust_analyzer = {
				settings = {
					["rust-analyzer"] = {
						cargo = { allFeatures = true },
						checkOnSave = { command = "clippy" },
					},
				},
			},

			-- C / C++
			clangd = {},

			-- Zig
			zls = {},

			-- Haskell
			hls = {
				mason = false,
			},

			-- Java
			jdtls = {},

			-- JS / TS / React
			tsserver = {},
			eslint = {},
			tailwindcss = {},

			-- Web
			html = {},
			cssls = {},
			emmet_language_server = {
				filetypes = {
					"html",
					"css",
					"scss",
					"javascriptreact",
					"typescriptreact",
					"vue",
					"svelte",
				},
			},

			-- Bash
			bashls = {},
		}

		opts.servers = vim.tbl_deep_extend("force", opts.servers, my_servers)
		return opts
	end,

	setup = {
		-- C# csharp_ls
		csharp_ls = function(_, opts)
			opts.handlers = opts.handlers or {}

			-- force using the global tool in PATH
			opts.cmd = { "csharp-ls" }

			local orig_on_attach = opts.on_attach
			opts.on_attach = function(client, bufnr)
				if orig_on_attach then
					orig_on_attach(client, bufnr)
				end

				-- Neovim 0.11 style inlay hints
				if vim.lsp.inlay_hint and client.server_capabilities.inlayHintProvider then
					vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
				end
			end

			require("lspconfig").csharp_ls.setup(opts)
			return true
		end,

		-- Haskell
		hls = function(_, opts)
			opts.cmd = { "haskell-language-server-wrapper", "--lsp" }

			require("lspconfig").hls.setup(opts)
			return true
		end,
	},
}
