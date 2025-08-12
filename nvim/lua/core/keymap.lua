-- Set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

----------------------- General Keymaps -------------------
-- Window navigation
keymap.set("n", "<C-k>", ":wincmd k<CR>", { silent = true, desc = "Go up" })
keymap.set("n", "<C-j>", ":wincmd j<CR>", { silent = true, desc = "Go down" })
keymap.set("n", "<C-h>", ":wincmd h<CR>", { silent = true, desc = "Go left" })
keymap.set("n", "<C-l>", ":wincmd l<CR>", { silent = true, desc = "Go right" })

-- Copy & paste
keymap.set("v", "<C-c>", '"+y', { noremap = true, silent = true, desc = "Copy" })
keymap.set("n", "<C-c>", '"+yy', { noremap = true, silent = true, desc = "Copy line" })
keymap.set("n", "<C-v>", '"+p', { noremap = true, silent = true, desc = "Paste" })
keymap.set("i", "<C-v>", "<C-r>+", { noremap = true, silent = true, desc = "Paste in insert mode" })

-- Undo
keymap.set("n", "<C-z>", "u", { noremap = true, silent = true, desc = "Undo" })
keymap.set("i", "<C-z>", "<C-o>u", { noremap = true, silent = true, desc = "Undo in insert mode" })

-- Select all
keymap.set("n", "<C-a>", "ggVG", { noremap = true, silent = true, desc = "Select all" })

-- Save file
keymap.set({ "n" }, "<C-s>", "<Esc>:w<CR>", { noremap = true, silent = true, desc = "Save file" })

-- Delete word
keymap.set("i", "<C-H>", "<C-w>", { noremap = true, silent = true, desc = "Delete word" })

-- Select line
keymap.set("n", "<CR>", "V", { noremap = true, silent = true, desc = "Select line" })

-- Move line
keymap.set("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true, desc = "Move line up" })
keymap.set("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true, desc = "Move line down" })

-- Buffer navigation
keymap.set("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true, desc = "Next buffer" })
keymap.set("n", "<S-Tab>", ":bprev<CR>", { noremap = true, silent = true, desc = "Prev buffer" })

-- Quit Neovim
keymap.set("n", "<C-q>", ":qa<CR>", { desc = "Quit Neovim" })

-- Clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear highlights" })

-- Window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split vertical" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split horizontal" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equal split size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close split" })

-- Normal mode mappings for line navigation
keymap.set("n", "<Down>", "gj", { noremap = true, silent = true })
keymap.set("n", "<Up>", "gk", { noremap = true, silent = true })

-- Insert mode mappings for line navigation
keymap.set("i", "<Down>", "<C-o>gj", { noremap = true, silent = true })
keymap.set("i", "<Up>", "<C-o>gk", { noremap = true, silent = true })

-- Visual mode mappings for line navigation
keymap.set("v", "<Down>", "gj", { noremap = true, silent = true })
keymap.set("v", "<Up>", "gk", { noremap = true, silent = true })

keymap.set("t", "<Esc>", "<C-\\><C-n>", { silent = true })
