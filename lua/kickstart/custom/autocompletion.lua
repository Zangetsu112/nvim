return {
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets" },
		-- use a release tag to download pre-built binaries
		version = "1.*",
		opts = {
			-- 'enter' for enter to accept
			keymap = { preset = "enter" },
			-- (Default) Only show the documentation popup when manually triggered
			completion = { documentation = { auto_show = false } },
			appearance = {
				kind_icons = {
					Function = "[Function]",
					Method = "[Method]",
					Field = "[Field]",
					Variable = "[Var]",
					Property = "[Property]",
					Keyword = "[Keyword]",
					Struct = "[Struct]",
					Enum = "[Enum]",
					EnumMember = "[Enum]",
					Snippet = "[Snippet]",
					Text = "[Text]",
					Module = "[Module]",
					Constructor = "[Constr]",
				},
			},

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},

			-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
			fuzzy = { implementation = "lua" },
		},
		opts_extend = { "sources.default" },
		signature = { enabled = false },
	}
}
