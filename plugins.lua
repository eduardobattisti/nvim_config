local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "stevearc/conform.nvim",
    --  for users those who want auto-save conform + lazyloading!
    -- event = "BufWritePre"
    config = function()
      require "custom.configs.conform"
    end,
  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
  {
    "theprimeagen/harpoon",
    lazy = false,
    config = function()
      local mark = require "harpoon.mark"
      local ui = require "harpoon.ui"


      vim.keymap.set("n", "<leader>ha", mark.add_file)
      vim.keymap.set("n", "<leader>hr", mark.rm_file)
      vim.keymap.set("n", "<leader>hc", mark.clear_all)
      vim.keymap.set("n", "<leader>hm", ui.toggle_quick_menu)

      vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end)
      vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end)
      vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end)
      vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end)
    end,
  },
  {
    'barrett-ruth/import-cost.nvim',
    build = 'sh install.sh yarn',
    event = "BufEnter",
    ft = {'js', 'ts', 'vue', 'tsx', 'jsx'},
    config = true
  },
  {
    "fedepujol/move.nvim",
    event = "BufRead"
  },
  {
      "danymat/neogen",
      dependencies = "nvim-treesitter/nvim-treesitter",
      event = "BufEnter",
      config = true,
      version = "*"
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({})
    end
  },
  {
    "m4xshen/smartcolumn.nvim",
    event = "FileType",
    opts = {
      colorcolumn = { "80", "120" },
    }
  },
  {
    "mbbill/undotree",
    lazy = false,
    config = function() vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle) end,
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    lazy = false,
    config = function()
      vim.keymap.set("n", "<leader>gg", vim.cmd.LazyGit)
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    lazy = false,
    config = function()
      local ufo = require('ufo')

      vim.o.foldcolumn = '1' -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
      vim.keymap.set('n', 'zR', ufo.openAllFolds)
      vim.keymap.set('n', 'zM', ufo.closeAllFolds)

      ufo.setup()
    end,
    provider_selector = function(_, filetype, buftype)
      return (filetype == "" or buftype == "nofile") and "indent" -- only use indent until a file is opened
        or { "treesitter", "indent" } -- if file opened, try to use treesitter if available
    end,
  },
}

return plugins
