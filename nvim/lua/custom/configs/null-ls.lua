local null_ls = require('null-ls')
  
local opts = {
  sources = {
    null-ls.builtins.diagnostics.ruff,
  }
}

return opts
