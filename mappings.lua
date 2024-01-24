---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },

    --  format with conform
    ["<leader>fm"] = {
      function()
        require("conform").format()
      end,
      "formatting",
    },
    ["<C-s>"] = { ":w!<cr>", desc = "Save File" }, -- change description but the same command,
    ["<C-d>"] = { "<C-d>zz", desc = "Keep cursor on middle of the screen" },
    ["<C-u>"] = { "<C-u>zz", desc = "Keep cursor on middle of the screen"},
    ["<n>"] = { "nzzzv", desc = "Keep cursor on middle of the screen when highlight" },
    ["<N>"] = { "Nzzzv",  desc = "Keep cursor on middle of the screen when highlight" },
    ["<leader>s"] = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], desc = "Update all words under cursor on the file" },
    ["<leader>tt"] = {
      function()
        require("base46").toggle_transparency()
      end,
      "Toggle transparency",
    },
    ["<C-Right>"] = { "<C-w><", desc = "Increase screen right" },
    ["<C-Left>"] = { "<C-w>>", desc = "Increase screen left" },
    ["<C-Up>"] = { "<C-w>+", desc = "Increase screen height" },
    ["<C-Down>"] = { "<C-w>-", desc = "Decrease screen height" },
  },
  v = {
    [">"] = { ">gv", "indent"},
    ["<A-k>"] = {":MoveBlock -1<CR>"},
    ["<A-j>"] = {":MoveBlock 1<CR>"},
    ["<A-h>"] = {":MoveHBlock -1<CR>"},
    ["<A-l>"] = {":MoveHBlock 1<CR>"},
  },
}

-- more keybinds!

return M
