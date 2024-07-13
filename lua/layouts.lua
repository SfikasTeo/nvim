------------------------------------------------------------
-- Lang-mappings for Colemak DHm
------------------------------------------------------------

-- Set Custom Keymaps
local set = vim.keymap.set
local opts = { noremap = true, silent = true }

local colemak_langmap = {
	{ "m", "h" },
	{ "n", "j" },
	{ "e", "k" },
	{ "i", "l" },
	{ "h", "e" },
	{ "j", "n" },
	{ "k", "m" },
	{ "l", "i" },
}

local qwerty_langmap = {
    { "m", "m" },
    { "n", "n" },
    { "e", "e" },
    { "i", "i" },
    { "h", "h" },
    { "j", "j" },
    { "k", "k" },
    { "l", "l" },
}

local colemak_mappings = {
	{ { "n", "v", "o" }, "<C-n>", "4j" },
	{ { "n", "v", "o" }, "<C-e>", "4k" },
}

local qwerty_mappings = {
	{ { "n", "v", "o" }, "<C-j>", "4j" },
	{ { "n", "v", "o" }, "<C-k>", "4k" },
}

-- Function to generate the langmap string
local function generate_langmap(mappings)
	-- Mappings include the base, capital, and control variations
	local full_mappings = {}

	for _, mapping in ipairs(mappings) do
		local from, to = mapping[1], mapping[2]
			table.insert(full_mappings, string.format("%s%s", from, to))
			table.insert(full_mappings, string.format("%s%s", from:upper(), to:upper()))
	end

	-- Concatenate all mappings into a single string
	return table.concat(full_mappings, ",")
end

local function generate_keymaps(mappings)
    for _, mapping in ipairs(mappings) do
        local modes, key, action = mapping[1], mapping[2], mapping[3]
            set(modes, key, action, opts)
    end
end

vim.g.layout = "qwerty"

local function toggle_layout()
    if vim.g.layout == "colemak" then
        vim.g.layout = "qwerty"
        local langmap_string = generate_langmap(qwerty_langmap)
        vim.opt.langmap = langmap_string
        generate_keymaps(qwerty_mappings)
    else
        vim.g.layout = "colemak"
        local langmap_string = generate_langmap(colemak_langmap)
        vim.opt.langmap = langmap_string
        generate_keymaps(colemak_mappings)
    end
end

-- Command to toggle between layout
vim.api.nvim_create_user_command("ToggleLayout", toggle_layout, {})

