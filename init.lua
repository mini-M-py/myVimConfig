--require("manish")
require("set")
require("remap")

vim.pack.add({
	{ src = "https://github.com/mbbill/undotree" },
	{ src = "https://github.com/brianhuster/live-preview.nvim" },
	{ src = "https://github.com/echasnovski/mini.pairs" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("*") },
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
    { src = "https://github.com/folke/tokyonight.nvim.git" },
    { src = "https://github.com/tiwari-krishna/retroWire-nvim" },
    { src = "https://github.com/tiwari-krishna/nvHopper.nvim.git" }
})

require("lsp")
require("extra")
require("retroWire")

