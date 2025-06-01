-- Neo-tree is a Neovim plugin to browse the file system
return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  config = function()
    require('neo-tree').setup {
      close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
      popup_border_style = 'rounded',
      enable_git_status = true,
      enable_diagnostics = true,
      default_component_configs = {
        indent = {
          indent_size = 1,
          with_markers = true,
          indent_marker = '│',
          last_indent_marker = '└',
          highlight = 'NeoTreeIndentMarker',
        },
        icon = {
          -- No folder/file icons.
          folder_closed = '',
          folder_open = '|',
          folder_empty = '',
          default = '',
          highlight = 'NeoTreeFileIcon',
        },
        name = {
          trailing_slash = false,
          use_git_status_colors = true,
          highlight = 'NeoTreeFileName',
        },
        git_status = {
          symbols = {
            -- Change type
            added = '',      -- Redundant with git_status_colors
            modified = '',   -- Redundant with git_status_colors
            deleted = '[D]', -- this can only be used in the git_status source
            renamed = '[R]', -- this can only be used in the git_status source
            -- Status type
            untracked = '[U]',
            ignored = '[I]',
            unstaged = '[U]',
            staged = '[S]',
            conflict = '[=]',
          },
        },
      },

      filesystem = {
        filtered_items = {
          visible = false, -- when true, they will just be displayed differently than normal items
          hide_dotfiles = true,
          hide_gitignored = true,
        },
        follow_current_file = {
          enabled = false,                      -- This will find and focus the file in the active buffer every time
          leave_dirs_open = false,              -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
        hijack_netrw_behavior = 'open_default', -- netrw disabled, opening a directory opens neo-tree
        use_libuv_file_watcher = false,         -- Will use OS level file watchers instead of relying on nvim autocmd events.
      },

      git_status = {
        window = {
          position = 'float',
          mappings = {
            ['A'] = 'git_add_all',
            ['gu'] = 'git_unstage_file',
            ['ga'] = 'git_add_file',
            ['gr'] = 'git_revert_file',
            ['gc'] = 'git_commit',
            ['gp'] = 'git_push',
            ['gg'] = 'git_commit_and_push',
            ['oc'] = { 'order_by_created', nowait = false },
            ['om'] = { 'order_by_modified', nowait = false },
          },
        },
      },
    }

    vim.keymap.set('n', '\\', ':Neotree toggle<CR>')
  end,
}
