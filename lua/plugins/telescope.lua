-- lua/plugins/telescope.lua
local telescope = require('telescope')
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local set = vim.keymap.set

local default_set = { noremap = true, silent = true }
local allow_remap = { noremap = false, silent = true }

telescope.setup{
  pickers = {
    find_files = {
			find_command = {
        "rg",
        "--files",
        "--hidden",
        "--glob",
        "!**/.git/*"
      },
    },
  },
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden',
      '--glob',
      "!**/.git/*"
    },
    mappings = {
      i = { -- insert_mode mappings
        [",,"] = {"<esc>", type = "command"},
        ["jj"] = {"<esc>", type = "command"},
        ["<C-v>"] = actions.select_vertical,
        ["<C-s>"] = actions.select_horizontal,
        ["<C-q>"] = actions.send_to_qflist,
        ["<C-t>"] = actions.select_tab,
      },
      n = { -- normal_mode mappings
        [",,"] = actions.close,
        ["<C-v>"] = actions.select_vertical,
        ["<C-s>"] = actions.select_horizontal,
        ["<C-q>"] = actions.send_to_qflist,
        ["<C-t>"] = actions.select_tab,
     },
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown{}
    },
  },
}

-- Set telescope specific keybindings

-- Vim pickers
set('n', '<C-f>b', builtin.buffers, default_set)                     -- Buffers
set('n', '<C-f>o', builtin.oldfiles, default_set)                    -- Recently opened Files
set('n', '<C-f>F', builtin.find_files, default_set)                  -- Find Files in CWD
set('n', '<C-f>G', builtin.live_grep, default_set)                   -- Grep CWD
set('n', '<C-f>h', builtin.highlights, default_set)                  -- Find Help Pages
set('n', '<C-f>H', builtin.help_tags, default_set)                   -- Find Help Pages
set('n', '<C-f>c', builtin.commands, default_set)                    -- Access Commands
set('n', '<C-f>R', builtin.registers, default_set)                   -- Access Registers
set('n', '<C-f>M', builtin.man_pages, default_set)                   -- Find man pages
set('n', '<C-f>l', builtin.loclist, default_set)                     -- List Location list
set('n', '<C-f>j', builtin.jumplist, default_set)                    -- List Jump list
set('n', '<C-f>q', builtin.quickfix, default_set)                    -- Access commands
set('n', '<C-f>s', builtin.spell_suggest, default_set)               -- List spell suggestions
set('n', '<C-f>k', builtin.keymaps, default_set)                     -- List keymaps
set('n', '<C-f>m', builtin.marks, default_set)                       -- List Marks
set('n', '<C-f>d', builtin.diagnostics, default_set)                 -- List Diagnostics
set('n', '<C-f>t', builtin.treesitter, default_set)                  -- Lists tree-sitter objects

-- Lsp Bindings
set('n', 'gr', builtin.lsp_references, default_set)                  -- Goto Symbol references
set('n', '<C-f>r', builtin.lsp_references, default_set)              -- Find references
set('n', '<C-f>I', builtin.lsp_incoming_calls, default_set)          -- Goto Symbol incoming calls
set('n', '<C-f>O', builtin.lsp_outgoing_calls, default_set)          -- Goto Symbol outgoing calls

-- Advanced Bindings

-- Utility function to check if inside a Git repo and get root
local function get_git_root()
    if vim.fn.systemlist("git rev-parse --is-inside-work-tree")[1] == "true" then
        return vim.fn.systemlist("git rev-parse --show-toplevel")[1]
    end
end

local function path_to_clipboard(prompt_bufnr)
    local selection = action_state.get_selected_entry(prompt_bufnr)
    local picker = action_state.get_current_picker(prompt_bufnr)
    -- check if you are inside a git repo
    local cwd = picker.cwd or vim.fn.getcwd()

    -- Construct an absolute path
    local path = cwd .. '/' .. selection.value
    print(path)
    path = vim.fn.fnamemodify(path, ":p")

    vim.fn.setreg('+', path)
end

-- Customize live_grep & find_files dynamically
local function is_inside_git_repo()
  local inside_git_repo = vim.fn.systemlist("git rev-parse --is-inside-work-tree")[1]
  return inside_git_repo == "true"
end

local function custom_live_grep()
  local opts = {}

  -- if on git repo change cwd
  local git_root = get_git_root()
    if git_root then
        opts.cwd = git_root
    end

  -- Add mappings
  opts.attach_mappings = function(prompt_bufnr, map)
      map('n', 'yy', function() path_to_clipboard(prompt_bufnr) end)
      return true
  end

  require('telescope.builtin').live_grep(opts)
end

local function custom_find_files()
  local opts = {}

  -- if on git repo change cwd
  local git_root = get_git_root()
    if git_root then
        opts.cwd = git_root
    end

  -- Add mappings
  opts.attach_mappings = function(prompt_bufnr, map)
      map('n', 'yy', function() path_to_clipboard(prompt_bufnr) end)
      return true
  end

  require('telescope.builtin').find_files(opts)
end

set('n', '<C-f>g', custom_live_grep, default_set)          -- Grep Git Repo or CWD
set('n', '<C-f>f', custom_find_files, default_set)         -- Find Files in Git Repo or CWD

-- Load extensions
telescope.load_extension("ui-select")

