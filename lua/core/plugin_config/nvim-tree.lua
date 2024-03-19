vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


local function opts(desc)
  return { desc = "nvim-tree: " ..desc, buffer = true, noremap = true, silent = true, nowait = true }
end

local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"
  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  api.tree.toggle_gitignore_filter()


  -- custom mappings
  vim.keymap.set('n', '<c-n>', ':NvimTreeFindFileToggle<CR>')

  vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
  --vim.keymap.set('n', '<leader>ov', api.node.open.vertical, { buffer = true })
  vim.keymap.set('n', 'V', api.node.open.vertical, { buffer = true })
  vim.keymap.set('n', 'H', api.node.open.horizontal, { buffer = true })
end

require("nvim-tree").setup {
  on_attach = my_on_attach,
}

