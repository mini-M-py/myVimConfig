local lsp_zero = require('lsp-zero')

-- Your on_attach: all keymaps go here
lsp_zero.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  -- Your mappings
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

  -- Disable signature help
  client.server_capabilities.signatureHelpProvider = false
end)

-- Diagnostic settings
vim.diagnostic.config({
  virtual_text = true
})

-- Mason setup
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {"lua_ls", "html", "cssls", "ts_ls", "pylsp", "clangd"},
  handlers = {
    lsp_zero.default_setup, -- default for all

    -- Lua LS
    lua_ls = function()
      local opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(opts)
    end,

    -- HTML
    html = function()
      require('lspconfig').html.setup({
        capabilities = lsp_zero.capabilities,
        settings = {
          html = {
            filetypes = { "html", "templ" },
            init_options = {
              provideFormatter = true,
              embeddedLanguages = {
                css = true,
                javascript = true,
              },
              configurationSection = { "html", "css", "javascript" },
            }
          }
        }
      })
    end,

    -- Pylsp
    pylsp = function()
      require('lspconfig').pylsp.setup({
        settings = {
          pylsp = {
            plugins = {
              black = { enabled = true },
              autopep8 = { enabled = true },
              yapf = { enabled = false },
              pylint = { enabled = true },
              pyflakes = { enabled = true },
              pycodestyle = { enabled = false },
              pylsp_mypy = { enabled = true },
              jedi_completion = { fuzzy = true },
              pyls_isort = { enabled = true }
            },
          },
        },
        capabilities = lsp_zero.capabilities
      })
    end,
  },
})

