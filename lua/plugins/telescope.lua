-- lua/plugins/telescope.lua
local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local set = vim.keymap.set
local default_set = { noremap = true, silent = true }

telescope.setup({
	pickers = {
		find_files = {
			find_command = {
				"rg",
				"--files",
				"--hidden",
				"--glob",
				"!**/.git/*",
			},
		},
        diagnostics = {
            layout_strategy = "vertical",
        },
	},
	defaults = {
		layout_config = {
			width = 0.9,
			height = 0.9,
			horizontal = {
				preview_width = 0.6,
			},
			vertical = {
				preview_height = 0.6,
			},
		},
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--hidden",
			"--glob",
			"!**/.git/*",
		},
		mappings = {
			i = { -- insert_mode mappings
				["ii"] = { "<esc>", type = "command" },
				["<C-c>"] = actions.close,
				["<C-q>"] = actions.send_to_qflist,
				["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
				["<C-w>v"] = actions.select_vertical,
				["<C-w>s"] = actions.select_horizontal,
				["<C-w>t"] = actions.select_tab,
                ["<C-w>o"] = actions.select_default,
			},
			n = { -- normal_mode mappings
				["<C-c>"] = actions.close,
                ["<C-q>"] = actions.send_to_qflist,
				["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
				["<C-w>v"] = actions.select_vertical,
				["<C-w>s"] = actions.select_horizontal,
				["<C-w>t"] = actions.select_tab,
                ["<C-w>o"] = actions.select_default,
			},
		},
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
	},
})

-- Set telescope specific keybindings

-- Vim pickers

-- f actions
set("n", "<C-f>b", builtin.buffers, default_set)            -- Find available Buffers
set("n", "<C-f>o", builtin.oldfiles, default_set)           -- Find recently opened Files
set("n", "<C-f>E", builtin.find_files, default_set)         -- Find files in CWD
set("n", "<C-f>G", builtin.live_grep, default_set)          -- Grep inside files in CWD
set("n", "<C-f>/", builtin.highlights, default_set)         -- Find Highlights
set("n", "<C-f>c", builtin.commands, default_set)           -- Find available Commands
set("n", "<C-f>R", builtin.registers, default_set)          -- Find register contents
set("n", "<C-f>l", builtin.loclist, default_set)            -- List Location list
set("n", "<C-f>j", builtin.jumplist, default_set)           -- List Jump list
set("n", "<C-f>q", builtin.quickfix, default_set)           -- List Quickfix list
set("n", "<C-f>m", builtin.marks, default_set)              -- List Marks
set("n", "<C-f>t", builtin.treesitter, default_set)         -- Lists tree-sitter objects
set("n", "<C-f>d", builtin.diagnostics, default_set)        -- List diagnostics/bugs
set("n", "<C-f>a", vim.lsp.buf.code_action, default_set)    -- List code-actions

-- g actions
set("n", "<C-g>i", builtin.lsp_incoming_calls, default_set) -- Find symbol incoming calls
set("n", "<C-g>o", builtin.lsp_outgoing_calls, default_set) -- Find symbol outgoing calls
set("n", "gr", builtin.lsp_references, default_set)         -- Find symbol references

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
	local path = cwd .. "/" .. selection.value
	print(path)
	path = vim.fn.fnamemodify(path, ":p")

	vim.fn.setreg("+", path)
end

-- Customize live_grep & find_files dynamically
local function custom_live_grep()
	local opts = {}

	-- if on git repo change cwd
	local git_root = get_git_root()
	if git_root then
		opts.cwd = git_root
	end

	-- Add mappings
	opts.attach_mappings = function(prompt_bufnr, map)
		map("n", "yy", function()
			path_to_clipboard(prompt_bufnr)
		end)
		return true
	end

	require("telescope.builtin").live_grep(opts)
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
		map("n", "yy", function()
			path_to_clipboard(prompt_bufnr)
		end)
		return true
	end

	require("telescope.builtin").find_files(opts)
end

set("n", "<C-f>g", custom_live_grep, default_set) -- Grep Git Repo or CWD
set("n", "<C-f>e", custom_find_files, default_set) -- Find Files in Git Repo or CWD

-- User commands
local usr_cmd = vim.api.nvim_create_user_command
usr_cmd('Telescope help-tags', function()
  require('telescope.builtin').help_tags()
end, {desc = 'Open Telescope Help Tags'})

usr_cmd('Telescope keymaps', function()
  require('telescope.builtin').keymaps()
end, {desc = 'Open Telescope Keymaps'})

usr_cmd('Telescope man-pages', function()
  require('telescope.builtin').man_pages()
end, {desc = 'Open Telescope Man Pages'})

-- Load extensions
telescope.load_extension("ui-select")

