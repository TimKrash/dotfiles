local servers = {
  "pyright",
  "jsonls",
  "omnisharp",
}

local settings = {
  ui = {
    icons = {
      package_installed = "",
      package_pending = "",
      package_uninstalled = "",
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
  }
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = true,
})


local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
  print("Error! Missing lspconfig!\n")
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  server = vim.split(server, "@")[1]

  local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)

  -- If LSP server has user defined custom configs then merge with above default opts
  -- Opts are defined as lsp.settings.<server name>
  if require_ok then
    opts = vim.tbl_deep_extend("force", conf_opts, opts)
  end
  lspconfig[server].setup(opts)
end
