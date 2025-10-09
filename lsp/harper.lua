local blink = require("blink.cmp")

return {
    cmd = { 'harper-ls', '--stdio' },
  filetypes = {
    'c',
    'cpp',
    'cs',
    'gitcommit',
    'go',
    'html',
    'java',
    'javascript',
    'lua',
    'markdown',
    'nix',
    'python',
    'ruby',
    'rust',
    'swift',
    'toml',
    'typescript',
    'typescriptreact',
    'haskell',
    'cmake',
    'typst',
    'php',
    'dart',
    'clojure',
    'sh',
  },
  root_markers = { '.git' },
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
