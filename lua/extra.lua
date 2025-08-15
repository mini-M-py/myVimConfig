require("tokyonight").setup({
  style = "night",
  styles = {
    functions = { italic = false},
    comments = { italic = false},
    keywords = { italic = false},
  },
 })

function ColorMyPencils(color)
	vim.cmd.colorscheme(color)
	vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})

end
ColorMyPencils("tokyonight-night")

require("fzf-lua").setup({
    winopts = {
        height = 0.85,
        width = 0.85,
        preview = {
            layout = "flex",
            scrollbar = "float",
        },
    },
    fzf_opts = {
        ["--layout"] = "reverse",
    },
})

local function editNvim ()
    require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
end

vim.keymap.set("n", "<leader>pf", "<CMD>FzfLua files<CR>", { desc = "Find Files" })
vim.keymap.set("n", "<leader>fe", editNvim , { desc = "Find Neovim config Files" })
vim.keymap.set("n", "<leader>ps", "<CMD>FzfLua live_grep<CR>", { desc = "Live Grep" })
vim.keymap.set("n", "<M-b>", "<CMD>FzfLua buffers<CR>", { desc = "Find Buffers" })
vim.keymap.set("n", "<leader>fa", "<CMD>FzfLua builtin<CR>", { desc = "Find Builtin Stuff" })

--treesitter
require'nvim-treesitter.configs'.setup {
    ensure_installed = {  "javascript", "cpp", "python", "c", "lua", "vim", "vimdoc", "query", "typescript", "tsx" },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        autotag = true,
        additional_vim_regex_highlighting = false,
    },

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<Enter>",
            node_incremental = "<Enter>",
            scope_incremental = "\\",
            node_decremental = "<Backspace>",
        },
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- auto-jump forward to textobj

            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
        },
    },
}

-- undotree
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

-- Oil Configuration
require("oil").setup({
	view_options = {
		show_hidden = true,
	},
})

vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Mini Stuff
require("mini.pairs").setup()

-- Live Preview
vim.keymap.set("n", "<leader>lp", "<CMD>LivePreview start<CR>", { desc = "Live Preview Start" })
vim.keymap.set("n", "<leader>ls", "<CMD>LivePreview close<CR>", { desc = "Live Preview Close" })

--nvhopper
require("hopper").setup({
	open_mapping = "<leader>m",
	jump_mappings = {'<leader>1', '<leader>2', '<leader>3' }
})

