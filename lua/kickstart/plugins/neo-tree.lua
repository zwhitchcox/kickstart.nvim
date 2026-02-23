-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    -- Sync tree root with cwd
    filesystem = {
      follow_current_file = {
        enabled = true, -- Highlight current file in tree
      },
      use_libuv_file_watcher = true, -- Auto-refresh on file changes
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
      },
      window = {
        mappings = {
          ['\\'] = 'close_window',
          ['l'] = 'open', -- Open file/folder
          ['h'] = 'close_node', -- Close folder
          ['v'] = 'open_vsplit', -- Open in vertical split
          ['s'] = 'open_split', -- Open in horizontal split
          ['u'] = 'navigate_up', -- Go up one directory
          ['C'] = 'set_root', -- Set folder as root
          ['O'] = function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            vim.fn.system { 'open', '-R', path }
          end, -- Reveal in Finder
        },
      },
    },
    window = {
      width = 30,
      position = 'left',
      auto_resize = false,
    },
  },
}
