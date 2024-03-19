vim.api.nvim_command([[
  autocmd BufEnter *.tfvars :setlocal filetype=terraform
]])

vim.api.nvim_command([[
  autocmd BufEnter *.yml :setlocal indentkeys-=0#
]])

