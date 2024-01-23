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
    ["<leader>s"] = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], desc = "Update all words under cursor on the file" }
  },
  v = {
    [">"] = { ">gv", "indent"},
    ["<A-k>"] = {":MoveBlock -1<CR>"},
    ["<A-j>"] = {":MoveBlock 1<CR>"},
    ["<A-h>"] = {":MoveHBlock -1<CR>"},
    ["<A-l>"] = {":MoveHBlock 1<CR>"},
  },
  i = {
    ["<C-h>"] = {"<Left>"},
    ["<C-j>"] = {"<Down>"},
    ["<C-k>"] = {"<Up>"},
    ["<C-l>"] = {"<Right>"},
  },
}

-- more keybinds!

return M
