local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "markdown",
    "markdown_inline",
    "vue",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",
    "eslint",
    "tailwindcss-language-server",
    "emmet-ls",
    "intelephense",

    -- c/cpp stuff
    "clangd",
    "clang-format",

    -- vue
    "volar",
    "tsserver",
  },
  opts = {
    handlers = {
      function(server_name)
        local server_config = {}
        local lspconfig = require('lspconfig')

        if require("neoconf").get(server_name .. ".disable") then
          return
        end
        if server_name == "volar" then
          server_config.filetypes = { 'vue', 'typescript', 'javascript' }
        end

        lspconfig[server_name].setup(server_config)
      end,
    }
  }
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M
