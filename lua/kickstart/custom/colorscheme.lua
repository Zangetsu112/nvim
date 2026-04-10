return {
	{
		"rebelot/kanagawa.nvim",
		opts = {
			-- Remove backgrounds
			transparent = true,
			overrides = function(colors)
				return {
					Normal              = { bg = "none" },
					NormalNC            = { bg = "none" },
					NormalFloat         = { bg = "none" },
					FloatBorder         = { bg = "none" },
					FloatTitle          = { bg = "none" },

					-- Transparent sign column and signs
					SignColumn          = { bg = "none" },

					-- Git signs (from gitsigns.nvim)
					GitSignsAdd         = { bg = "none" },
					GitSignsChange      = { bg = "none" },
					GitSignsDelete      = { bg = "none" },

					-- Diagnostics signs (from LSP)
					DiagnosticSignError = { bg = "none" },
					DiagnosticSignWarn  = { bg = "none" },
					DiagnosticSignInfo  = { bg = "none" },
					DiagnosticSignHint  = { bg = "none" },

					-- Line Number
					LineNr              = { bg = "none" },
					CursorLineNr        = { bg = "none" },

					-- Telescope
					TelescopeBorder     = { bg = "none" },
					StatusLine          = { fg = "none", bg = "none" },
					StatusLineNC        = { fg = "none", bg = "none" },

				}
			end,
		},
		priority = 1000, -- Make sure to load this before all the other start plugins.
		init = function()
			vim.cmd.colorscheme("kanagawa-wave")
		end,
	}
}
