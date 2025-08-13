local lsp_zero = require('lsp-zero')
local vi = vim
-- Your on_attach: all keymaps go here
lsp_zero.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  -- Your mappings
  vi.keymap.set("n", "gd", function() vi.lsp.buf.definition() end, opts)
  vi.keymap.set("n", "K", function() vi.lsp.buf.hover() end, opts)
  vi.keymap.set("n", "<leader>vws", function() vi.lsp.buf.workspace_symbol() end, opts)
  vi.keymap.set("n", "<leader>vd", function() vi.diagnostic.open_float() end, opts)
  vi.keymap.set("n", "[d", function() vi.diagnostic.goto_next() end, opts)
  vi.keymap.set("n", "]d", function() vi.diagnostic.goto_prev() end, opts)
  vi.keymap.set("n", "<leader>vca", function() vi.lsp.buf.code_action() end, opts)
  vi.keymap.set("n", "<leader>vrr", function() vi.lsp.buf.references() end, opts)
  vi.keymap.set("n", "<leader>vrn", function() vi.lsp.buf.rename() end, opts)
  vi.keymap.set("i", "<C-h>", function() vi.lsp.buf.signature_help() end, opts)

  -- Disable signature help
  client.server_capabilities.signatureHelpProvider = false
end)

-- Diagnostic settings
vi.diagnostic.config({
  virtual_text = {
      prefix = '●',
      spacing = 4,
  },
  signs = {
      text = {
        [vi.diagnostic.severity.ERROR] = "",
        [vi.diagnostic.severity.WARN] = "",
		[vi.diagnostic.severity.INFO] = "",
		[vi.diagnostic.severity.HINT] = "",
      }
  },
  update_in_insert = false,
  severity_sort = true

})

-- Mason setup
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { "ts_ls", "lua_ls", "html", "pylsp"},
handlers = {
  lsp_zero.default_setup,
  lua_ls = function()
    local opts = lsp_zero.nvi_lua_ls()
    require('lspconfig').lua_ls.setup(opts)
  end,

  clangd = function()
        require('lspconfig').clangd.setup({
            cmd = { "clangd" },
            filetypes = { "c", "c++"},
            capabilities = lsp_zero.capabilities
        })
  end,

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

  pylsp = function()
    require('lspconfig').pylsp.setup({
        settings = {
            pylsp = {
                plugins = {
                    reporting = { enabled = false },
                    pycodestyle = { enabled = false },
                    flake8 = { enabled = false },
                    pylint = { enabled = false },
                    pyflakes = { enabled = false },
                    mypy = { enabled = false },
                }
            }
        },
      capabilities = lsp_zero.capabilities
    })
  end,

}
})

