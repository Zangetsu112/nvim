return {
	--  Additional override configurations for LSP. Available keys are:
	--  - cmd (table): Override the default command used to start the server
	--  - filetypes (table): Override the default list of associated filetypes for the server
	--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
	--  - settings (table): Override the default settings passed when initializing the server.
	-- This is like a LSP profile page

	clangd = {},

	-- Uncomment to enable Lua LSP
	-- lua_ls = {
	--   settings = {
	--     Lua = {
	--       completion = {
	--         callSnippet = "Replace",
	--       },
	--       diagnostics = { disable = { "missing-fields" } },
	--     },
	--   },
	-- },

	-- python_lsp_server = {
	--   -- pylsp.plugins.pycodestyle.maxLineLength = nil,
	--   "pylsp": {
	--     "plugins": {
	--         "pycodestyle": {
	--             "maxLineLength": 100,
	--         },
	--     },
	--   },
	-- },
}
