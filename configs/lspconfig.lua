local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local lspconfig = require "lspconfig"
local os = require('os')
local io = require('io')

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd", "volar", "tailwindcss" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Volar Config Start
local function on_new_config(new_config, new_root_dir)
  local function get_typescript_server_path(root_dir)
    local project_root = lspconfig.util.find_node_modules_ancestor(root_dir)
    return project_root and (lspconfig.util.path.join(project_root, 'node_modules', 'typescript', 'lib', 'tsserverlibrary.js'))
      or ''
  end

  if
    new_config.init_options
    and new_config.init_options.typescript
    and new_config.init_options.typescript.tsdk == ''
  then
    new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
  end
end

local volar_cmd = {'vue-language-server', '--stdio'}
local volar_root_dir = lspconfig.util.root_pattern 'package.json'

local function get_nvm_node_version()
  local nvm_dir = os.getenv("NVM_DIR" )

  if nvm_dir == nil then
    return ''
  end

  local handle = io.popen('node -v')

  if handle == nil then
    return ''
  end

  local node_version = handle:read('*a')
  handle:close()

  -- Remove trailing newline character
  node_version = node_version:gsub('\n', '')

  local nvm_node_version_path = nvm_dir .. "/versions/node/" .. node_version

  return nvm_node_version_path
end

local function get_tsserver_node_global_path()
  local nvm_node_version_path = get_nvm_node_version()
  local tsserver_global_path = nvm_node_version_path .. "/lib/node_modules/typescript/lib"

  return tsserver_global_path
end

lspconfig.volar.setup {
  cmd = volar_cmd,
  root_dir = volar_root_dir,
  on_new_config = on_new_config,
  filetypes = { 'vue'},
  init_options = {
    typescript = {
      tsdk = get_tsserver_node_global_path()
    },
  }
}
-- Volar Config End
