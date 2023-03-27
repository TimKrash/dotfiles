local ok, _ = pcall(require, "lspconfig")
if not ok then
  print("Missing LSP Config!\n")
  return
end

require "user.lsp.mason"
require "user.lsp.handlers".setup()
