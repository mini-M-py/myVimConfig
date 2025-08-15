local things = {
	-- LSP Servers
	"lua-language-server",
	"clangd",
	"typescript-language-server",
	"pyright",

	-- Linters
	-- "luacheck",
	-- -- "cpplint",
	-- "eslint_d",
	-- "pylint",
}

require("mason").setup()
require("blink.cmp").setup()

require("mason-tool-installer").setup({
	ensure_installed = things,
	auto_update = false,
	run_on_start = false,
})
vim.lsp.enable({
	"lua_ls",
	"clangd",
	"ts_ls",
	"pyright",
})

local function on_attach(client, bufnr)
	local opts = { buffer = bufnr, silent = true }
    vim.keymap.set("n", "gd",  vim.lsp.buf.definition , opts)
  vim.keymap.set("n", "K",  vim.lsp.buf.hover , opts)
  vim.keymap.set("n", "<leader>vws",  vim.lsp.buf.workspace_symbol , opts)
  vim.keymap.set("n", "<leader>vd",  vim.diagnostic.open_float , opts)
  vim.keymap.set("n", "[d",  vim.diagnostic.goto_next , opts)
  vim.keymap.set("n", "]d",  vim.diagnostic.goto_prev , opts)
  vim.keymap.set("n", "<leader>vca",  vim.lsp.buf.code_action , opts)
  vim.keymap.set("n", "<leader>vrr",  vim.lsp.buf.references , opts)
  vim.keymap.set("n", "<leader>vrn",  vim.lsp.buf.rename , opts)
  vim.keymap.set("i", "<C-h>",  vim.lsp.buf.signature_help , opts)
end

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local bufnr = args.buf
		on_attach(client, bufnr)
	end,
})

vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
		spacing = 4,
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.WARN] = "WarningMsg",
		},
	},
	float = {
		border = "rounded",
		format = function(d)
			return ("%s (%s) [%s]"):format(d.message, d.source, d.code or d.user_data.lsp.code)
		end,
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

-- Path of Mason LSPs
local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
local current_path = vim.env.PATH or ""

local path_entries = vim.split(current_path, ":")
local clean_path_entries = {}
local seen = {}

for _, entry in ipairs(path_entries) do
	if entry ~= mason_bin and entry ~= "" and not seen[entry] then
		seen[entry] = true
		table.insert(clean_path_entries, entry)
	end
end

local new_path = mason_bin .. ":" .. table.concat(clean_path_entries, ":")
vim.env.PATH = new_path

if vim.fn.isdirectory(mason_bin) == 0 then
	vim.fn.mkdir(mason_bin, "p")
end
