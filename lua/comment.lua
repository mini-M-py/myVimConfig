-- Universal toggle comment function (fixed)
local function comment()
  local start_line = vim.fn.line("v")
  local end_line   = vim.fn.line(".")
  local cs = vim.bo.commentstring
  local leader = cs:match("^(.*)%%s")

  if not leader then
    vim.notify("No commentstring defined for this filetype!", vim.log.levels.WARN)
    return
  end
  leader = leader:gsub("%s+$", "") -- trim spaces

  for lnum = start_line, end_line do
    local line = vim.fn.getline(lnum)
    local indent, content = line:match("^(%s*)(.*)$")

    if not vim.startswith(vim.trim(content), leader) then
      vim.fn.setline(lnum, indent .. leader .. " " .. content)
    end
  end
end

local function uncomment()
  local start_line = vim.fn.line("v")
  local end_line   = vim.fn.line(".")
  local cs = vim.bo.commentstring
  local leader = cs:match("^(.*)%%s")

  if not leader then
    vim.notify("No commentstring defined for this filetype!", vim.log.levels.WARN)
    return
  end
  leader = leader:gsub("%s+$", "") -- trim spaces

  for lnum = start_line, end_line do
    local line = vim.fn.getline(lnum)
    local indent, content = line:match("^(%s*)(.*)$")

    if vim.startswith(vim.trim(content), leader) then
      content = content:gsub("^" .. vim.pesc(leader) .. "%s?", "", 1)
      vim.fn.setline(lnum, indent .. content)
      end
    end
end

-- Map it: <leader>c in visual mode
vim.keymap.set("v", "<leader>c", comment, { noremap = true, silent = true })
vim.keymap.set("v", "<leader>v", uncomment, { noremap = true, silent = true })

