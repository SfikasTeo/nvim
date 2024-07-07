-- lua/plugins/lsp/taplo.lua

return {
	on_attach = function(_, bufnr)
		vim.keymap.set("n", "K", function()
			if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
				require("crates").show_popup()
			else
				vim.lsp.buf.hover()
			end
		end, { desc = "Show Crate Documentation", buffer = bufnr })
	end,
}
