vim.g.mapleader = " "
vim.keymap.set("n","<leader>pv", function() vim.cmd("Ex") end)

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then
        options = vin.tbl_extend('force', options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end








map('i', '9' , '(')
map('i', '0', ')')
map('i', '8', '*')
map('i', '7', '&')
map('i', '6' ,'^')
map('i', '5', '%')
map('i', '4', '$')
map('i', '3', '#')
map('i' ,'2', '@')
map('i', '1', '!')




map('i', '(', '9')
map('i', '*', '8')
map('i', '&', '7')
map('i', '^', '6')
map('i', '%', '5')
map('i', '$', '4')
map('i', '#', '3')
map('i', '@', '2')
map('i', '!', '1')
map('i', ')', '0')

