vim.g.mapleader = " " 
vim.keymap.set("n","<leader>pv", function() vim.cmd("Ex") end)

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then
        options = vin.tbl_extend('force', options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
