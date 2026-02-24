-- init.lua

vim.o.number = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.wrap = false
vim.o.hlsearch = false
vim.o.signcolumn = 'yes'

-- Space as the leader key
vim.g.mapleader = vim.keycode('<Space>')

-- Basic clipboard interaction
vim.keymap.set({'n', 'x'}, 'gy', '"+y', {desc = 'Copy to clipboard'})
vim.keymap.set({'n', 'x'}, 'gp', '"+p', {desc = 'Paste clipboard text'})

-- Command shortcuts
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>', {desc = 'Save file'})
vim.keymap.set('n', '<leader>q', '<cmd>quitall<cr>', {desc = 'Exit vim'})

-- escape is missing from IPad keyboards so '§' is used instead

vim.keymap.set('i', '§', '<ESC>', {})

-- buffer navigation
vim.keymap.set('n', '<leader><Right>', '<cmd>bn<cr>', {})
vim.keymap.set('n', '<leader><Left>',  '<cmd>bp<cr>', {})
vim.keymap.set('n', '<leader><Down>',  '<cmd>bd<cr>', {})
vim.keymap.set('n', '<leader><Up>',    '<cmd>enew<cr>i', {})

-- clear highlights
vim.keymap.set('n', '<leader>n', '<cmd>noh<cr>', {})

vim.keymap.set('n', '<leader>jq', '<cmd>%!jq -S .<cr>', {})
vim.keymap.set('n', '<leader>jc', '<cmd>%!jq -c .<cr>', {})

-- yank word
vim.keymap.set('n', '<leader>y', 'viwy', {})

-- simple surround mappings
vim.keymap.set('n', '<leader>sv', 'viwxi${}<ESC>P', {})     -- variable
vim.keymap.set('n', '<leader>sV', 'viwxi"${}"<ESC>hP', {})  -- variable quoted

vim.keymap.set('v', '<leader>sq', "xi''<ESC>P", {})         -- quotes
vim.keymap.set('v', '<leader>sd', 'xi""<ESC>P', {})         -- double quotes
vim.keymap.set('v', '<leader>sb', 'xi()<ESC>P', {})         -- brackets
vim.keymap.set('v', '<leader>ss', 'xi{}<ESC>P', {})         -- squiglies
vim.keymap.set('v', '<leader>sa', 'xi[]<ESC>P', {})         -- array
vim.keymap.set('v', '<leader>sv', 'xi${}<ESC>P', {})        -- variable
vim.keymap.set('v', '<leader>sV', 'xi"${}"<ESC>hP', {})     -- variable quoted
vim.keymap.set('v', '<leader>sc', 'xi$()<ESC>P', {})        -- capture

-- function
vim.keymap.set('n', '<leader>ss', 'A {<cr>}<ESC>ko', {})

-- ------------------

local ok, MiniDeps = pcall(require, 'mini.deps')
if not ok then
  vim.notify('[WARN] mini.deps module not found', vim.log.levels.WARN)
  return
end

MiniDeps.setup({})

require('mini.snippets').setup({})
require('mini.completion').setup({})
-- require('mini.cursorword').setup({})  -- ugly

-- require('mini.files').setup({})
-- vim.keymap.set('n', '<leader>e', '<cmd>lua MiniFiles.open()<cr>', {desc = 'File explorer'})

require('mini.pick').setup({})
vim.keymap.set('n', '<leader><space>', '<cmd>Pick buffers<cr>', {desc = 'Search open files'})
vim.keymap.set('n', '<leader>ff', '<cmd>Pick files<cr>', {desc = 'Search all files'})
vim.keymap.set('n', '<leader>fh', '<cmd>Pick help<cr>', {desc = 'Search help tags'})

-- airline

MiniDeps.add('vim-airline/vim-airline')
MiniDeps.add('vim-airline/vim-airline-themes')

-- lastplace

MiniDeps.add('ethanholz/nvim-lastplace')

require'nvim-lastplace'.setup{}

-- tokyonight

MiniDeps.add('folke/tokyonight.nvim')

require("tokyonight").setup({
  on_colors = function (colors)
  colors.fg_gutter = "#b2b8cf"
  end
})

vim.cmd.colorscheme('tokyonight')

-- treesitter

MiniDeps.add('nvim-treesitter/nvim-treesitter')

require('nvim-treesitter').setup({
  install_dir = vim.fn.stdpath('data') .. '/site',
  ensure_installed = { 'lua', 'vimdoc', 'nushell'},
  highlight = { enable = true },
})


-- toggleterm

MiniDeps.add('akinsho/toggleterm.nvim')

require('toggleterm').setup {
  size = 20,
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = "float",
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
}

-- oil

MiniDeps.add('stevearc/oil.nvim')

require("oil").setup({
  -- Id is automatically added at the beginning, and name at the end
  -- See :help oil-columns
  columns = {
    -- "icon",
    -- "permissions",
    -- "size",
    -- "mtime",
  },
  -- Buffer-local options to use for oil buffers
  buf_options = {
    buflisted = false,
    bufhidden = "hide",
  },
  -- Window-local options to use for oil buffers
  win_options = {
    wrap = false,
    signcolumn = "no",
    cursorcolumn = false,
    foldcolumn = "0",
    spell = false,
    list = false,
    conceallevel = 3,
    concealcursor = "n",
  },
  -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`
  default_file_explorer = true,
  -- Restore window options to previous values when leaving an oil buffer
  restore_win_options = true,
  -- Skip the confirmation popup for simple operations
  skip_confirm_for_simple_edits = false,
  -- Deleted files will be removed with the trash_command (below).
  delete_to_trash = false,
  -- Change this to customize the command used when deleting to trash
  trash_command = "trash-put",
  -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
  prompt_save_on_select_new_entry = true,
  -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
  -- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
  -- Additionally, if it is a string that matches "actions.<name>",
  -- it will use the mapping at require("oil.actions").<name>
  -- Set to `false` to remove a keymap
  -- See :help oil-actions for a list of all available actions
  keymaps = {
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.select",
    ["<C-s>"] = "actions.select_vsplit",
    ["<C-h>"] = "actions.select_split",
    ["<C-t>"] = "actions.select_tab",
    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = "actions.close",
    ["<C-l>"] = "actions.refresh",
    ["-"] = "actions.parent",
    ["_"] = "actions.open_cwd",
    ["`"] = "actions.cd",
    ["~"] = "actions.tcd",
    ["g."] = "actions.toggle_hidden",
  },
  -- Set to false to disable all of the above keymaps
  use_default_keymaps = true,
  view_options = {
    -- Show files and directories that start with "."
    show_hidden = true,
    -- This function defines what is considered a "hidden" file
    is_hidden_file = function(name, bufnr)
      return vim.startswith(name, ".")
    end,
    -- This function defines what will never be shown, even when `show_hidden` is set
    is_always_hidden = function(name, bufnr)
      return false
    end,
  },
  -- Configuration for the floating window in oil.open_float
  float = {
    -- Padding around the floating window
    padding = 2,
    max_width = 0,
    max_height = 0,
    border = "rounded",
    win_options = {
      winblend = 10,
    },
    -- This is the config that will be passed to nvim_open_win.
    -- Change values here to customize the layout
    override = function(conf)
      return conf
    end,
  },
  -- Configuration for the actions floating preview window
  preview = {
    -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    -- min_width and max_width can be a single value or a list of mixed integer/float types.
    -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
    max_width = 0.9,
    -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
    min_width = { 40, 0.4 },
    -- optionally define an integer/float for the exact width of the preview window
    width = nil,
    -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    -- min_height and max_height can be a single value or a list of mixed integer/float types.
    -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
    max_height = 0.9,
    -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
    min_height = { 5, 0.1 },
    -- optionally define an integer/float for the exact height of the preview window
    height = nil,
    border = "rounded",
    win_options = {
      winblend = 0,
    },
  },
  -- Configuration for the floating progress window
  progress = {
    max_width = 0.9,
    min_width = { 40, 0.4 },
    width = nil,
    max_height = { 10, 0.9 },
    min_height = { 5, 0.1 },
    height = nil,
    border = "rounded",
    minimized_border = "none",
    win_options = {
      winblend = 0,
    },
  },
})

vim.keymap.set("n", "-", require('oil').open, { desc = "Open current directory" })

-- lsp-config

-- List of compatible language servers is here:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

MiniDeps.add('neovim/nvim-lspconfig')

-- vim.lsp.enable({'gopls', 'rust_analyzer'})   -- broken
vim.lsp.enable({'nushell'})
vim.lsp.enable({'python'})
