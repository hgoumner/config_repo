-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map("n", "n", "nzz", { desc = "Center next match" })
map("n", "N", "Nzz", { desc = "Center previous match" })
map("n", "*", "*zz", { desc = "Center next match of current word" })
map("n", "#", "#zz", { desc = "Center previous match of current word" })
