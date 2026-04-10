---@module 'lazy'
---@type LazySpec
return {
	'mfussenegger/nvim-dap',
	dependencies = {
		-- Debugger UI and dependency
		'rcarriga/nvim-dap-ui',
		'nvim-neotest/nvim-nio',

		-- Mason and connector to install Debugger from Neovim
		'mason-org/mason.nvim',
		'jay-babu/mason-nvim-dap.nvim',
	},
	keys = {
		-- Basic debugging keymaps, feel free to change to your liking!
		{ '<leader>dd', function() require('dap').continue() end,                                            desc = 'Debug: Start/Continue' },
		{ '<leader>dl', function() require('dap').step_into() end,                                           desc = 'Debug: Step Into' },
		{ '<leader>dj', function() require('dap').step_over() end,                                           desc = 'Debug: Step Over' },
		{ '<leader>dh', function() require('dap').step_out() end,                                            desc = 'Debug: Step Out' },
		{ '<leader>dx', function() require('dap').terminate() end,                                           desc = 'Debug: Terminate' },

		{ '<leader>db', function() require('dap').toggle_breakpoint() end,                                   desc = 'Debug: Toggle Breakpoint' },
		{ '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, desc = 'Debug: Set Breakpoint' },
		-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
		{ '<F7>',       function() require('dapui').toggle() end,                                            desc = 'Debug: See last session result.' },
	},
	config = function()
		local dap = require 'dap'
		local dapui = require 'dapui'

		require('mason-nvim-dap').setup {
			handlers = {},
			ensure_installed = {},
		}

		---@diagnostic disable-next-line: missing-fields
		dapui.setup {
			-- Set icons to characters that are more likely to work in every terminal.
			--    Feel free to remove or use ones that you like more! :)
			--    Don't feel like these are good choices.
			icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
			---@diagnostic disable-next-line: missing-fields
			controls = {
				icons = {
					pause = '⏸',
					play = '▶',
					step_into = '⏎',
					step_over = '⏭',
					step_out = '⏮',
					step_back = 'b',
					run_last = '▶▶',
					terminate = '⏹',
					disconnect = '⏏',
				},
			},
		}

		-- Change breakpoint icons
		local breakpoint_icons = {
			Breakpoint = '●',
			BreakpointCondition = '⊜',
			BreakpointRejected = '⊘',
			LogPoint =
			'◆',
			Stopped = '⭔'
		}
		for type, icon in pairs(breakpoint_icons) do
			local tp = 'Dap' .. type
			local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
			vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
		end

		dap.listeners.after.event_initialized['dapui_config'] = dapui.open
		dap.listeners.before.event_terminated['dapui_config'] = dapui.close
		dap.listeners.before.event_exited['dapui_config'] = dapui.close
		dap.adapters.codelldb = {
			type = "executable",
			command = "codelldb"
		}
		

		-- INFO: There is two types of internal DAP config tables:
		-- 1) dap.adapters tells DAP now to start up an adapter and with what parameters
		-- 2) dap.configurations.<filetype> tells the DAP server how to attach itself to the debugee, each configuration for a filetype can have nested configurations (object of objects? {not sure what Lua calls them}) that are differentiated by names and can be selected from a dropdown when debugging
		-- More info refer :help dap.txt (Needs to be manually loaded if still using Lazy in the future :Lazy load nvim-dap)

		dap.adapters.debugpy = {
			-- Tells DAP to look for the debugpy adapter in the virtualenv folder:req
			type = "executable";
			-- TODO: Add a condition for it to look at root level req maybe?
			-- 	If local req deos not exist then fallback to root else display warning
			command = './req/bin/python';
			args = {'-m', 'debugpy'};
		}

		dap.configurations.python = {
			{
				type = 'debugpy';
				request = 'launch';
				name = "Launch file";
				program = "${file}";
				pythonPath = function()
				  return '/usr/bin/python'
				end;
      			},
    		}

		dap.configurations.cpp = {
			{
				name = "Launch file",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
				end,
				cwd = '${workspaceFolder}',
				stopOnEntry = true,
			},
		}

		dap.configurations.c = dap.configurations.cpp


	end,
}
