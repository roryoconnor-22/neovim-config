require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "jedi_language_server",
    "terraformls",
    "omnisharp",
    "tsserver"
  }
})

-- vim.lsp.set_log_level("debug")
vim.lsp.set_log_level("off")

local on_attach = function(_, _)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
  vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {})
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
end


local capabilities = require('cmp_nvim_lsp').default_capabilities()

local on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT'
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
              -- Depending on the usage, you might want to add additional paths here.
              -- E.g.: For using `vim.*` functions, add vim.env.VIMRUNTIME/lua.
              -- "${3rd}/luv/library"
              -- "${3rd}/busted/library",
            }
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
            -- library = vim.api.nvim_get_runtime_file("", true)
          }
        }
      })
    end
    return true
end

require'lspconfig'.lua_ls.setup {
  on_init = on_init,
  on_attach = on_attach,
  capabilities = capabilities,
}

-- require("lspconfig").lua_ls.setup {
  -- on_attach = on_attach,
  -- capabilities = capabilities,
-- }

require("lspconfig").tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

require("lspconfig").terraformls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

require("lspconfig").omnisharp.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

require("lspconfig").jedi_language_server.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
