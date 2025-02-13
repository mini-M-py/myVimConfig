local base = require("lsp-zero")
local on_attach = base.on_attach
local capabilities = base.capabilities
base.preset("recommended")
local lspconfig = require('lspconfig')
local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')

mason.setup()
mason_lspconfig.setup({
    ensure_installed = {"lua_ls", "html", "cssls", "ts_ls", "pylsp"}
})

base.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

vim.diagnostic.config({
    virtual_text = true
})

on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

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
end)


lspconfig.lua_ls.setup{
    on_attach = function(client, buffer)
        client.server_capabilities.signatureHelpProvider = false
    end,
    capabilities = capabilities,
}

lspconfig.ts_ls.setup{
    on_attach = function(client, buffer)
        client.server_capabilities.signatureHelpProvider = false
    end,
    capabilities = capabilities
}

lspconfig.cssls.setup{
    on_attach = function (client, buffer)
        client.server_capabilities.signatureHelpProvider = false;
    end,
    capabilities = capabilities,
}

lspconfig.html.setup {
    on_attach = function(client, buffer)
        client.server_capabilities.signatureHelpProvider = false
    end,
    capabilities = capabilities, -- Ensure capabilities are set
    settings = { -- Move filetypes and init_options inside settings
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
}

lspconfig.clangd.setup{
	on_attach = function(client, buffer)
	    client.server_capabilities.signatureHelpProvider = false
	end,
	capabilities = capabilities,
    filetypes = {'c', 'cpp', 'objc', 'objcpp', 'cuda' }

}

lspconfig.pylsp.setup {
    on_attach = function(client, buffer)
        client.server_capabilities.signatureHelpProvider = false
    end,
    settings = {
        pylsp = {
            plugins = {
                black = true,
                autopep8 = true,
                yapf = false,
                pylint = true,
                pyflakes = true,
                pycodestyle = false ,
                pylsp_mypy = true,
                jedi_completion = {fuzzy = true},
                pyls_isort = true
            },
        },
    },

    capabilities = capabilities
}

base.setup()

