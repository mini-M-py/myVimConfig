local blink = require("blink.cmp")

return {
    cmd = {"ltex-ls"},
    filetypes = { "bib", "gitcommit", "markdown", "org", "plaintex", "rst",
     "rnoweb", "tex", "pandoc", "quarto", "rmd", "context", "html", "xhtml",
     "mail", "text" },
    root_makers = {".git"},
    settings = {
        ltex = {
            language = "en-GB",
        }
    },
	capabilities = vim.tbl_deep_extend(
		"force",
		{},
		vim.lsp.protocol.make_client_capabilities(),
		blink.get_lsp_capabilities(),
		{
			workspace = {
				fileOperations = {
					didRename = true,
					willRename = true,
				},
			},
		}
	),
}
